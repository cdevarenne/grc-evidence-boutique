---
type: Stack Component
title: Memorystore (Redis)
description: "An optional managed Redis store that replaces the in-cluster cache for carts."
resource: ../../upstream/terraform/memorystore.tf
tags: [infrastructure, terraform, redis]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
verified:
  - by: "human:cdevarenne"
    at: "2026-10-01T15:00:00-07:00"
---
# What it is

The `google_redis_instance` "redis-cart" (Redis 7.0) in `upstream/terraform/memorystore.tf`, created when `var.memorystore` is true.

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): access to the cart data
- [CC6.6 — System Boundary Protection](../controls/cc6.6.md): the store's network exposure
