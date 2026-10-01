---
type: Stack Component
title: GKE cluster
description: "The Google Kubernetes Engine cluster that runs the services."
resource: ../../upstream/terraform/main.tf
tags: [infrastructure, terraform, gke]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T15:00:00-07:00"
---
# What it is

The `google_container_cluster` in `upstream/terraform/main.tf`, onto which Terraform applies the Kubernetes manifests.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): who and what can reach the cluster and its workloads
- [CC6.6 — System Boundary Protection](../controls/cc6.6.md): the cluster's network boundary
