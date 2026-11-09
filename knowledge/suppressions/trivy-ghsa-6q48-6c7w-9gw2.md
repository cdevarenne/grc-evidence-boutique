---
type: Suppression
title: GHSA-6q48-6c7w-9gw2 in 4 files
kind: accepted-risk
finding:
  tool: trivy
  rule_id: GHSA-6q48-6c7w-9gw2
  targets:
  - upstream/src/emailservice/requirements.txt
  - upstream/src/loadgenerator/requirements.txt
  - upstream/src/recommendationservice/requirements.txt
  - upstream/src/shoppingassistantservice/requirements.txt
owner: human:cdevarenne
approved: '2026-11-09'
expires: '2026-12-09'
tags:
- suppression
generated:
  by: grc-evidence/2.3.1
  at: '2026-11-09T22:01:03+00:00'
verified:
  - by: "human:cdevarenne"
    at: "2026-11-09T14:10:36-08:00"
---
# Reason

Trivy reports upstream's `certifi 2024.7.4` in `src/emailservice/requirements.txt` and `src/recommendationservice/requirements.txt`, and `certifi 2025.8.3` in `src/loadgenerator/requirements.txt` and `src/shoppingassistantservice/requirements.txt` (critical: certifi bundles emSign root CAs with compromised intermediate CA keys). The advisory was published after this repo's baseline. The files are part of Google's `microservices-demo`, included unmodified as a submodule; this repo scans them and does not change upstream code, and upstream's `main` still pins the same versions. The findings stay on [CC7.1 — Vulnerability Detection](../controls/cc7.1.md) as known, accepted risks for 30 days.

From the last scan (scanner text, quoted as reported):

- `upstream/src/emailservice/requirements.txt`: critical, "certifi 2024.7.4: certifi bundles emSign root CAs with compromised intermediate CA keys" (controls: soc2:cc7.1)
- `upstream/src/loadgenerator/requirements.txt`: critical, "certifi 2025.8.3: certifi bundles emSign root CAs with compromised intermediate CA keys" (controls: soc2:cc7.1)
- `upstream/src/recommendationservice/requirements.txt`: critical, "certifi 2024.7.4: certifi bundles emSign root CAs with compromised intermediate CA keys" (controls: soc2:cc7.1)
- `upstream/src/shoppingassistantservice/requirements.txt`: critical, "certifi 2025.8.3: certifi bundles emSign root CAs with compromised intermediate CA keys" (controls: soc2:cc7.1)

# Compensating control

The acceptance expires on 2026-12-09, so the findings fail the nightly gate again unless a person reviews them. Dependabot's monthly submodule update moves `upstream/` to upstream's latest commit; when upstream bumps it in a file, that file's finding goes away and its target shows as unused. Every other vulnerability finding still counts.
