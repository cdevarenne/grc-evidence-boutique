---
type: Suppression
title: Load generator in the default namespace (CKV_K8S_21)
description: "Accepted: the load generator is synthetic test traffic, not part of the shop, and production deploys leave it out."
kind: accepted-risk
finding:
  tool: checkov
  rule_id: CKV_K8S_21
  target: upstream/kubernetes-manifests/loadgenerator.yaml
owner: human:cdevarenne
approved: "2026-10-01"
expires: "2026-12-30"
tags: [suppression, kubernetes, cc6.1]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T17:51:32-07:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T17:56:00-07:00"
---
# Reason

The load generator sends synthetic shopper traffic to exercise the demo. It
holds no customer data and no credentials, and no other service calls it, so
running it in the default namespace does not widen anyone's access to the shop.
It stays on [CC6.1 — Logical Access](../controls/cc6.1.md) as a known, accepted
risk; every other service's namespace finding still counts.

# Compensating control

Production deploys leave the load generator out with upstream's
`kustomize/components/without-loadgenerator` component. This acceptance covers
only Checkov's rule on `kubernetes-manifests/loadgenerator.yaml`; Trivy's
equivalent finding (`KSV-0110`) is not suppressed and still counts.
