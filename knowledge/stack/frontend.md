---
type: Stack Component
title: frontend
description: "Serves the shop's website over HTTP; no sign-up or login, a session id for every visitor."
resource: ../../upstream/src/frontend/
tags: [service, go]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T15:00:00-07:00"
---
# What it is

Serves the shop's website over HTTP; no sign-up or login, a session id for every visitor. Written in Go; source in `upstream/src/frontend/`. Deployed by `upstream/kubernetes-manifests/frontend.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
- [CC6.6 — System Boundary Protection](../controls/cc6.6.md): its `frontend-external` LoadBalancer is the system's public entry point
