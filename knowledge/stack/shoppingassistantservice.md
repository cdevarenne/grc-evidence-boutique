---
type: Stack Component
title: shoppingassistantservice
description: "Answers shoppers' questions and suggests products: Gemini through LangChain, with product data retrieved from an AlloyDB vector store."
resource: ../../upstream/src/shoppingassistantservice/
tags: [service, python, ai, llm]
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-10-01T00:00:00+00:00"
---
# What it is

Answers shoppers' questions and suggests products: Gemini through LangChain, with product data retrieved from an AlloyDB vector store. Written in Python; source in `upstream/src/shoppingassistantservice/`. Its manifest exists only as a Kustomize component (`upstream/kustomize/components/shopping-assistant/`).

# Implements

- [CC6.1 — Logical Access](../controls/cc6.1.md): its container and Kubernetes manifest run with least privilege
- [CC7.1 — Vulnerability Detection](../controls/cc7.1.md): its dependencies and image are scanned for known vulnerabilities
- [CC8.1 — Change Management](../controls/cc8.1.md): its manifest deploys a pinned image tag
- [A.4 — Resources for AI systems](../controls/iso42001/a.4.md): the model provider, the vector store, and the service are recorded in the AI inventory
- [A.6 — AI system life cycle](../controls/iso42001/a.6.md): its model calls are bounded (timeout and token limit)
- [A.7 — Data for AI systems](../controls/iso42001/a.7.md): the prompts, retrieved product data, and answers it handles
- [Art. 50 — Transparency obligations for certain AI systems](../controls/eu-ai-act/art-50.md): it chats with shoppers, who must be told they are talking to an AI system
