---
okf_version: "0.2"
base_version: "1.2.0"
---
# Knowledge Bundle

Grounds okf-grc scans of this repository. A finding reaches a control only
through a `rule_ids` declaration here; a finding with none is a coverage gap.
Controls, crosswalks, scanners, and generic policies are copies of the okf-grc
base bundle (`grc check` reports drift); the stack and the suppressions are
this repository's own.

# Map

* [Controls](controls/) - SOC 2 criteria (mapped to NIST SP 800-53), ISO/IEC 42001 Annex A, and EU AI Act articles
* [Crosswalk](crosswalk/) - navigation links between frameworks; never a mapping
* [Stack](stack/) - this repository's components; each links the controls it implements
* [Policies](policies/) - guardrails (Rego, Semgrep) and the scanner rules that detect each
* [Scanners](scanners/) - DevSecOps tools and the controls they evidence
* [Suppressions](suppressions/) - reviewed, expiring false positives and accepted risks; never hidden
* [OSCAL output](oscal/component-definition.md) - the machine-readable output target
