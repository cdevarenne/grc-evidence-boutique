# The okf-grc engine, pinned to a release; local runs and CI use exactly this version.
OKF_GRC_VERSION := v1.5.0
GRC := uvx --from git+https://github.com/cdevarenne/okf-grc-skill@$(OKF_GRC_VERSION) grc
# The same engine with its optional LLM client, for triage (LLM_MODE=anthropic or claude-cli).
# CI passes RUN_ARGS=--require-clean and GATE_ARGS=--summary <file>.
GRC_LLM := uvx --from "okf-grc[llm] @ git+https://github.com/cdevarenne/okf-grc-skill@$(OKF_GRC_VERSION)" grc

.PHONY: bootstrap scan check gate baseline triage

bootstrap:  # the pinned scanners, into .tools/
	$(GRC) bootstrap

scan:       # out/: findings, mapping, OSCAL, report, run.json
	$(GRC) run $(RUN_ARGS)

check:      # base bundle copies unchanged; every concept reviewed by a person
	$(GRC) check

gate:       # fails if compliance got worse than expected/control-status.json
	$(GRC) gate $(GATE_ARGS)

baseline: scan  # rewrite expected/ in the same change as an upstream or engine bump
	$(GRC) gate --write-baseline

triage: scan  # proposals for coverage gaps -> out/proposals.json, for a person to decide; nothing is applied
	$(GRC_LLM) triage
