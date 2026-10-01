---
type: Stack Component
title: adservice
description: "Returns text ads for given context words."
resource: ../../upstream/src/adservice/
tags: [service, java]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
---
# What it is

Returns text ads for given context words. Written in Java; source in `upstream/src/adservice/`. Deployed by `upstream/kubernetes-manifests/adservice.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
