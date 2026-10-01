---
type: Stack Component
title: paymentservice
description: "Charges the given card details (mock) and returns a transaction id."
resource: ../../upstream/src/paymentservice/
tags: [service, nodejs]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
---
# What it is

Charges the given card details (mock) and returns a transaction id. Written in Node.js; source in `upstream/src/paymentservice/`. Deployed by `upstream/kubernetes-manifests/paymentservice.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
