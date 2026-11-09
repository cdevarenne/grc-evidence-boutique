---
type: Suppression
title: GHSA-78g4-xqwv-q3g8 in upstream/src/shoppingassistantservice/requirements.txt
kind: accepted-risk
finding:
  tool: trivy
  rule_id: GHSA-78g4-xqwv-q3g8
  target: upstream/src/shoppingassistantservice/requirements.txt
owner: human:cdevarenne
approved: '2026-11-09'
expires: '2026-12-09'
tags:
- suppression
generated:
  by: grc-evidence/2.3.1
  at: '2026-11-09T22:01:05+00:00'
verified:
  - by: "human:cdevarenne"
    at: "2026-11-09T14:10:36-08:00"
---
# Reason

Trivy reports upstream's `pillow 12.3.0` in `src/shoppingassistantservice/requirements.txt` (high: Bundled libopenjp2 2.5.4 in all wheels since 11.1.0 carries OSV-2025-219 heap-buffer-overflow write reachable from Image.open().load()). The advisory was published after this repo's baseline. The file is part of Google's `microservices-demo`, included unmodified as a submodule; this repo scans it and does not change upstream code, and upstream's `main` still pins the same version. It stays on [CC7.1 — Vulnerability Detection](../controls/cc7.1.md) as a known, accepted risk for 30 days.

From the last scan (scanner text, quoted as reported):

- `upstream/src/shoppingassistantservice/requirements.txt`: high, "pillow 12.3.0: Pillow: Bundled libopenjp2 2.5.4 in all wheels since 11.1.0 carries OSV-2025-219 heap-buffer-overflow write reachable from Image.open().load()" (controls: soc2:cc7.1)

# Compensating control

The acceptance expires on 2026-12-09, so the finding fails the nightly gate again unless a person reviews it. Dependabot's monthly submodule update moves `upstream/` to upstream's latest commit; if upstream bumps it, the finding goes away and this suppression shows as unused. Every other vulnerability finding still counts.
