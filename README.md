# okf-grc-demo-boutique

[okf-grc](https://github.com/cdevarenne/okf-grc-skill) applied to an app it was
not built around: Google's [microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)
("Online Boutique"), included unmodified as a git submodule at release v0.10.7
under `upstream/`. This repo adds only the compliance layer: the scan layout,
the knowledge bundle, the AI inventory, and CI. It is a worked example of
adopting the engine, not a compliance attestation of Online Boutique.

```
git clone --recurse-submodules https://github.com/cdevarenne/okf-grc-demo-boutique.git
cd okf-grc-demo-boutique
make bootstrap   # the pinned scanners, into .tools/
make scan        # out/: report.md, findings, mapping, OSCAL, run.json
make check       # base copies unchanged; every concept reviewed by a person
make gate        # fails if compliance got worse than expected/
```

The engine version is pinned once, in the [Makefile](Makefile)
(`OKF_GRC_VERSION`); local runs and CI use exactly that release through `uvx`.

## Walkthrough

### 1. Set up

`grc init --target upstream` copied the engine's base bundle (controls,
crosswalks, scanners, generic guardrails, and their Rego and Semgrep rules) into
`knowledge/` and `policies/`, and wrote a starter `grc.yaml`. Because `upstream/`
is a submodule, someone else's code, `init` put the AI inventory beside it, at
the repo root; it never writes into the submodule.

A person then wrote what only they know:

- **[`grc.yaml`](grc.yaml)**: the target is `upstream`; Conftest reads the
  Kubernetes manifests, the Terraform, the shopping assistant's manifest, and the
  inventory; `skip_paths` keeps Trivy and Checkov out of the Helm chart's
  unrendered templates, duplicate kustomize and release manifests, and upstream's
  own CI.
- **[`knowledge/stack/`](knowledge/stack/)**: one concept per service (12) plus
  GKE and Memorystore, each saying what it is and which controls it implements,
  each with a person's `verified` entry.
- **[`ai-inventory.yaml`](ai-inventory.yaml)**: the 12 components, and the one AI
  system, the shopping assistant (`sdk: langchain`), with the EU AI Act risk tier
  `limited` and the reason recorded beside it.

### 2. The first report

`make scan` runs Semgrep, Trivy (configuration and dependencies), Checkov, and
Conftest, maps each finding to a control only through a reviewed `rule_ids`
declaration, and writes `out/report.md`, OSCAL, and a run manifest. On this
repo, with okf-grc 1.4.0:

- **429 findings** (Trivy 244, Checkov 172, Conftest 12, Semgrep 1), of which 5
  rules are coverage gaps: findings no control claims.
- **7 controls `not-satisfied`**: SOC 2 A1.1, CC6.1, CC6.6, CC7.1, CC7.2, CC8.1,
  and ISO/IEC 42001 A.6 (the shopping assistant's LangChain call sets no
  timeout or token limit).
- **2 `no-violations-detected`** (A.4 and A.7: rules could have fired and did
  not), **4 `not-assessed`**, and **6 `not-applicable`** (the high-risk
  articles of the EU AI Act, at the declared `limited` tier).
- **EU AI Act Art. 50 reads `not-assessed`**, not clean: its only rule reads
  Anthropic SDK calls, and the inventory says the assistant uses LangChain
  (reason `rules-do-not-cover-sdk`).

No status is ever "satisfied": a scan can show violations or their absence,
not that a control works.

### 3. Triage one gap

The first scan left 47 rules (263 findings) with no control. `make triage`
asked a model (Claude Haiku 4.5, $0.04 for all 47) to propose a control or
`none` for each; proposals go to `out/proposals.json`, and only a person applies
them. For example, Checkov's `CKV_K8S_21` ("the default namespace should not be
used", 42 findings) was proposed for CC6.1 with high confidence. A person
agreed, and because the rule is generic, the mapping went into the engine's base
bundle (okf-grc 1.2.1, the `isolate-workloads` guardrail), next to Trivy's
equivalent `KSV-0110`, which triage had proposed as `none`. In all, 42 rules
were mapped; 5 stay gaps by decision (cluster labels, image pull policy
`Always`, `apt-get` recommends, the GKE release channel). `grc sync-base`
brought the new base into this repo.

### 4. Suppress one finding

[`knowledge/suppressions/loadgenerator-default-namespace.md`](knowledge/suppressions/loadgenerator-default-namespace.md)
accepts one risk: Checkov's `CKV_K8S_21` on the load generator, which sends
synthetic traffic and is left out of production deploys. A suppression names one
exact finding (tool, rule, file; no wildcards), an owner, a reason, and an
expiry at most 90 days out (here 2026-12-30). It changes how the finding counts,
never whether it is shown: the two findings stay on CC6.1, which stays
`not-satisfied`, marked accepted in the report and in OSCAL. Trivy's equivalent
finding on the same file is a different finding and still counts. After the
expiry the findings count again, and the gate fails until a person renews or
removes the suppression.

### 5. What CI does

- **Every pull request and push to `main`**
  ([`compliance.yml`](.github/workflows/compliance.yml)): bootstrap, `make check`,
  a scan that refuses inputs differing from the commit (`--require-clean`), and
  `make gate` against [`expected/control-status.json`](expected/control-status.json).
  The gate fails when a control turns `not-satisfied`, when a finding not in the
  baseline is `critical`, or when a suppression has expired. The job summary
  shows each control's status against the baseline; `out/` is uploaded as the
  `compliance` artifact.
- **Every night** ([`nightly.yml`](.github/workflows/nightly.yml)): the same scan
  of `main` with a fresh Trivy database, gating at `high`, so a newly published
  CVE fails the nightly run (GitHub notifies the owner) rather than an unrelated
  pull request.
- **Dependabot** ([`dependabot.yml`](.github/dependabot.yml)) proposes the
  submodule's next upstream commit monthly and action updates weekly, each after
  a 7-day cooldown. When a bump changes compliance, the author reviews it and
  runs `make baseline` in the same pull request, so the baseline moves only by
  review.

Actions are pinned to commit SHAs, the token is read-only, and no LLM runs in CI.

### 6. Through an agent

The engine's agent skill (`grc-continuous-compliance`) runs this pipeline from a
coding agent and drafts suppressions for a person to review. It is not yet
packaged for adopter repos; see
[okf-grc-skill#106](https://github.com/cdevarenne/okf-grc-skill/issues/106).

## Issues

This repo is an example, so it has no issue tracker of its own. Its issues live
with the engine, where anyone adopting okf-grc with their own code will look:
[okf-grc-skill issues labeled `adopter-demo`](https://github.com/cdevarenne/okf-grc-skill/issues?q=label%3Aadopter-demo).
