---
type: Stack Component
title: loadgenerator
description: "Sends a continuous stream of realistic shopping requests to the frontend; test traffic, not part of the shop."
resource: ../../upstream/src/loadgenerator/
tags: [service, python]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
---
# What it is

Sends a continuous stream of realistic shopping requests to the frontend; test traffic, not part of the shop. Written in Python (Locust); source in `upstream/src/loadgenerator/`. Deployed by `upstream/kubernetes-manifests/loadgenerator.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
