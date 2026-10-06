# The grc-evidence engine, pinned to a release; local runs and CI use exactly this version.
GRC_VERSION := v2.0.1
GRC := uvx --from git+https://github.com/cdevarenne/grc-evidence@$(GRC_VERSION) grc
# The same engine with its optional LLM client, for triage (LLM_MODE=anthropic or claude-cli).
# The workflow linter, pinned to the version the engine's own audit uses.
ZIZMOR := uvx zizmor@1.30.1
# CI passes RUN_ARGS=--require-clean and GATE_ARGS=--summary <file>.
GRC_LLM := uvx --from "grc-evidence[llm] @ git+https://github.com/cdevarenne/grc-evidence@$(GRC_VERSION)" grc
# With the MCP server too, for agent workflows (LLM_MODE=claude-cli on a Claude plan, or anthropic with a key).
GRC_AGENT := uvx --from "grc-evidence[llm,mcp] @ git+https://github.com/cdevarenne/grc-evidence@$(GRC_VERSION)" grc

# The GitHub collectors and the evidence ledger run only when asked: COLLECT= (empty) in the nightly job and
# for `make baseline`, with GH_TOKEN and GRC_PEOPLE_SALT set. Pull requests and local scans skip them.
COLLECT ?= --no-collect

.PHONY: bootstrap scan check gate baseline triage audit posture ledger window

bootstrap:  # the pinned scanners, into .tools/
	$(GRC) bootstrap

scan:       # out/: findings, mapping, OSCAL, report, run.json
	$(GRC) run $(COLLECT) $(RUN_ARGS)

check:      # base bundle copies unchanged; every concept reviewed by a person
	$(GRC) check

gate:       # fails if compliance got worse than expected/control-status.json
	$(GRC) gate $(GATE_ARGS)

baseline:  # rewrite expected/ in the same change as an upstream or engine bump; collects, so it needs the token and salt
	$(MAKE) scan COLLECT=
	$(GRC) gate --write-baseline

triage: scan  # proposals for coverage gaps -> out/proposals.json, for a person to decide; nothing is applied
	$(GRC_LLM) triage

audit:  # this repo's own workflows and Dependabot config (it has no dependencies of its own to scan)
	$(ZIZMOR) --no-progress .github

posture:  # a summary of the latest scan for the owner -> out/agent/, written only if it checks out
	$(GRC_AGENT) agent posture

ledger:     # the evidence ledger's hash chain and timestamps are intact
	$(GRC) ledger verify

window:     # out/window.md: each control's history over the audit window, from the ledger
	$(GRC) window
