# Compliance posture

The latest scan identified 7 controls with not-satisfied status, carrying 417 findings total. soc2:cc6.1 (188 findings) and soc2:cc7.1 (108 findings) are the largest, followed by soc2:cc8.1 (61 findings) and soc2:a1.1 (52 findings). Five rules have no control mapping, and one suppression is in effect through 2026-12-30.

## Controls not satisfied

| Control | Status | Findings | Largest groups |
|---|---|---|---|
| `soc2:cc6.1` | not-satisfied | 188 | checkov:CKV_K8S_21 (41), trivy:KSV-0020 (16), trivy:KSV-0021 (16), trivy:KSV-0104 (16) |
| `soc2:cc7.1` | not-satisfied | 108 | trivy:CVE-2026-25645 (4), trivy:CVE-2026-41907 (4), trivy:CVE-2026-44431 (4), trivy:CVE-2026-44432 (4) |
| `soc2:cc8.1` | not-satisfied | 61 | checkov:CKV_K8S_43 (13), checkov:CKV_K8S_14 (12), conftest:deny_latest_tag (12), trivy:KSV-0013 (12) |
| `soc2:a1.1` | not-satisfied | 52 | checkov:CKV_DOCKER_2 (13), trivy:DS-0026 (13) |
| `soc2:cc6.6` | not-satisfied | 6 | checkov:CKV_GCP_12 (1), checkov:CKV_GCP_20 (1), checkov:CKV_GCP_25 (1), checkov:CKV_GCP_64 (1) |
| `soc2:cc7.2` | not-satisfied | 1 | checkov:CKV_GCP_61 (1) |
| `iso42001:a.6` | not-satisfied | 1 | semgrep:llm-unbounded-call (1) |

## Coverage gaps

- `checkov:CKV_GCP_21`: 1 finding(s)
- `checkov:CKV_GCP_70`: 1 finding(s)
- `checkov:CKV_K8S_15`: 1 finding(s)
- `trivy:DS-0029`: 1 finding(s)
- `trivy:GCP-0051`: 1 finding(s)

## Suppressions

1 applied suppression: suppressions/loadgenerator-default-namespace (owner: human:cdevarenne, expires 2026-12-30, covers 2 findings on soc2:cc6.1 for loadgenerator's use of default namespace). No suppressions expiring, expired, pending, or unused.

## Next steps

- Address soc2:cc6.1 findings (188 total): prioritize checkov:CKV_K8S_21 (41) which flags default namespace usage across deployments
- Remediate soc2:cc7.1 vulnerabilities (108 findings): update dependencies and container base images to remove CVEs
- Implement image versioning for soc2:cc8.1 (61 findings): enforce non-latest tags and pin image provenance per conftest and Kubernetes policies
- Add health checks and resource limits for soc2:a1.1 (52 findings): configure Docker health checks and Kubernetes resource requests/limits
- Configure GKE cluster security for soc2:cc6.6 and soc2:cc7.2: enable network policies, private clusters, master authorized networks, and VPC flow logs
- Fix LLM unbounded call in iso42001:a.6: add timeout and token limits to LLM calls in shoppingassistantservice
- Map 5 uncovered rules to appropriate controls (checkov:CKV_GCP_21, CKV_GCP_70, CKV_K8S_15, trivy:DS-0029, trivy:GCP-0051)
- Monitor suppression expiration: loadgenerator-default-namespace expires 2026-12-30; renew or remediate before then

_Drafted by `grc agent posture` from tool results and checked against them; a person reviews it._
