# The okf-grc engine, pinned to a release; local runs and CI use exactly this version.
OKF_GRC_VERSION := v1.2.0
GRC := uvx --from git+https://github.com/cdevarenne/okf-grc-skill@$(OKF_GRC_VERSION) grc

.PHONY: bootstrap scan check gate

bootstrap:  # the pinned scanners, into .tools/
	$(GRC) bootstrap

scan:       # out/: findings, mapping, OSCAL, report, run.json
	$(GRC) run

check:      # base bundle copies unchanged; every concept reviewed by a person
	$(GRC) check

gate:       # fails if compliance got worse than expected/control-status.json
	$(GRC) gate
