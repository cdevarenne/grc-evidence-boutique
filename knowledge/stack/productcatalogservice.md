---
type: Stack Component
title: productcatalogservice
description: "Lists the products from a JSON file, and searches and returns single products."
resource: ../../upstream/src/productcatalogservice/
tags: [service, go]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T15:00:00-07:00"
---
# What it is

Lists the products from a JSON file, and searches and returns single products. Written in Go; source in `upstream/src/productcatalogservice/`. Deployed by `upstream/kubernetes-manifests/productcatalogservice.yaml`.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
