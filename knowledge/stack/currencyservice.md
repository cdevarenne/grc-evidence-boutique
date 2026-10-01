---
type: Stack Component
title: currencyservice
description: "Converts amounts between currencies with rates fetched from the European Central Bank; the busiest service."
resource: ../../upstream/src/currencyservice/
tags: [service, nodejs]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T15:00:00-07:00"
---
# What it is

Converts amounts between currencies with rates fetched from the European Central Bank; the busiest service. Written in Node.js; source in `upstream/src/currencyservice/`. Deployed by `upstream/kubernetes-manifests/currencyservice.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
