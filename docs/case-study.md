# Case study: compliance evidence for an app the engine was not built around

[okf-grc](https://github.com/cdevarenne/grc-evidence) scans a repository with
four pinned scanners and maps each finding to a SOC 2, ISO/IEC 42001, or EU AI
Act control, only through mappings a person has reviewed. This repository
applies it to Google's
[microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)
(Online Boutique v0.10.7: 12 services, Kubernetes, Terraform, and a LangChain
shopping assistant), included unmodified. Every figure below comes from this
repository and can be reproduced with `make scan`.

| | |
|---|---|
| **422 findings** | from Semgrep, Trivy, Checkov, and Conftest, each mapped to a control or listed as a coverage gap |
| **7 controls not satisfied** | 6 SOC 2 criteria and ISO/IEC 42001 A.6 (the assistant's model call sets no timeout or token limit); no control is ever reported as satisfied |
| **47 gap rules triaged for $0.04** | findings no control claimed, each given a proposed control or `none` by Claude Haiku 4.5; a person decided all 47: 42 mapped, 5 left as gaps |
| **3 catches** | an invented total that led to automatic validation, and two errors in a validated draft found by review, one of which changed the engine |

## What it took

A person wrote what only they know: the scan layout (`grc.yaml`), one short
concept per service saying which controls it implements, the AI inventory with
its EU AI Act risk tier and reason, and one reviewed suppression with an expiry.
The engine supplies the controls, the scanners, the mappings, and the outputs: a
report, OSCAL documents, and a run manifest that hashes every output and names
the commit. CI scans every pull request and fails if compliance gets worse than
the committed baseline; a nightly scan with a fresh vulnerability database
catches newly published CVEs.

## The three catches

The engine's agent workflow, `posture`, drafts a summary of the latest scan for
the repository's owner. The model may only read the results through the
engine's tools, and nothing it writes changes a status, a mapping, or a
suppression. Its draft is written only if it passes a check against what the
tools returned.

1. **An invented total, which led to validation.** In the prototype, before
   any check existed, the model summed the not-satisfied controls' findings and
   wrote 425; the tool results add up to 417. Reading that output is why every
   draft is now checked against the tool results before it is written. The
   check stops the same kind of error on its own: the latest run's first draft
   added two controls' counts into "296" and was rejected.
2. **A reported number attached to the wrong thing, found by review.** The
   published draft ([`examples/posture-1.7.0.md`](../examples/posture-1.7.0.md))
   said "plus 11 additional CVEs at 4 findings each". Eleven CVEs have 4
   findings each and four were already listed, so it is 7 more. It had passed,
   because 11 appeared in the tool results; the check verified that a number was
   reported, not what it counted.
3. **A step that contradicted a recorded decision, found by review.** The same
   draft proposed mapping the five remaining gaps to controls. A person had
   decided to leave them unmapped; the model could not know that.

## What changed because of catch 2

The engine now binds each number to what it counts: a count next to a control or
rule must be the one the tools reported for it, and a number on its own must be a
total the tools reported. A rejected draft goes back to the model once, with the
reasons. The first version of this check had a hole of its own, found on its
first run here: "and 7 more CVEs" passed because 7 was also an unrelated total,
so a number right beside an identifier must now match that identifier. The run
that followed ([`examples/posture.md`](../examples/posture.md), okf-grc 1.8.1)
was rejected first for "296", two controls' counts added together, and its
corrected draft passed with every number matching the scan. Both attempts are
replayed in the engine's tests.

Binding cannot tell a true derived count from a false one, so it rejects both: a
number reaches a person only if a tool reported it for that thing. It does not
check words. The 1.8.1 draft again proposes mapping the five gaps; a person still
reviews every draft.

## Costs

The triage of 47 gap rules: $0.04 through the API. A `posture` run: 3 turns and
about 10 tool calls, through Claude Code on a Claude plan (not billed; reported
at $0.06 to $0.10 including a correction round), or $0.04 through the API on the
engine's own sample app. The scan itself takes seconds once its scanners are
installed.
