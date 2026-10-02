# Compliance posture

The latest scan found 417 findings across 7 not-satisfied controls, with the largest groups in soc2:cc6.1 (188 findings led by CKV_K8S_21 with 41), soc2:cc7.1 (108 vulnerability findings), and soc2:cc8.1 (61 findings on unpinned image tags). Five coverage gaps exist where findings have no mapped control. One accepted-risk suppression is in force and expires 2026-12-30.

## Controls not satisfied

| Control | Status | Findings | Largest groups |
|---|---|---|---|
| `soc2:cc6.1` | not-satisfied | 188 | checkov:CKV_K8S_21 (41 findings), trivy:KSV-0020 (16), trivy:KSV-0021 (16), trivy:KSV-0104 (16) |
| `soc2:cc7.1` | not-satisfied | 108 | trivy:CVE-2026-25645 (4), trivy:CVE-2026-41907 (4), trivy:CVE-2026-44431 (4), trivy:CVE-2026-44432 (4), plus 11 additional CVEs at 4 findings each |
| `soc2:cc8.1` | not-satisfied | 61 | checkov:CKV_K8S_43 (13 findings), checkov:CKV_K8S_14 (12), conftest:deny_latest_tag (12) |
| `soc2:a1.1` | not-satisfied | 52 | checkov:CKV_DOCKER_2 (13 findings), trivy:DS-0026 (13) |
| `soc2:cc6.6` | not-satisfied | 6 | Six rules with 1 finding each: checkov:CKV_GCP_12, CKV_GCP_20, CKV_GCP_25, CKV_GCP_64, trivy:GCP-0059, GCP-0061 |
| `soc2:cc7.2` | not-satisfied | 1 | checkov:CKV_GCP_61 (1 finding) |
| `iso42001:a.6` | not-satisfied | 1 | semgrep:llm-unbounded-call (1 finding) |

## Coverage gaps

- `checkov:CKV_GCP_21`: 1 finding(s)
- `checkov:CKV_GCP_70`: 1 finding(s)
- `checkov:CKV_K8S_15`: 1 finding(s)
- `trivy:DS-0029`: 1 finding(s)
- `trivy:GCP-0051`: 1 finding(s)

## Suppressions

One accepted-risk suppression is in force: suppressions/loadgenerator-default-namespace (expires 2026-12-30) covers 2 findings in soc2:cc6.1 related to the loadgenerator Deployment and ServiceAccount running in the default namespace. No suppressions are expiring, expired, pending, or unused.

## Next steps

- Resolve 188 findings in soc2:cc6.1, starting with the 41 CKV_K8S_21 violations (Kubernetes workload namespaces), then the 16-finding groups for KSV-0020/0021/0104
- Address 108 vulnerability findings in soc2:cc7.1 (primarily Trivy CVE discoveries), with priority on protobufjs and urllib3 vulnerabilities affecting multiple services
- Pin all container image tags in soc2:cc8.1: 61 findings across unpinned Dockerfile base images (CKV_DOCKER_7, DS-0001) and Kubernetes deployment images (CKV_K8S_14, CKV_K8S_43, KSV-0013)
- Add health checks and resource requests/limits to containers in soc2:a1.1: 52 findings split between missing HEALTHCHECK instructions (13 CKV_DOCKER_2 + 13 trivy:DS-0026) and missing CPU/memory limits on loadgenerator and otel-collector
- Harden GKE cluster configuration in soc2:cc6.6: enable network policies (CKV_GCP_12), master authorized networks (CKV_GCP_20), private cluster (CKV_GCP_25), and private nodes (CKV_GCP_64)
- Map 5 coverage gaps to controls: CKV_GCP_21, CKV_GCP_70, CKV_K8S_15, trivy:DS-0029, trivy:GCP-0051 currently have no control assignment
- Enable VPC Flow Logs in soc2:cc7.2 (1 CKV_GCP_61 finding)
- Review loadgenerator suppression expiring 2026-12-30 and decide whether to renew or resolve the underlying namespace isolation finding

_Drafted by `grc agent posture` from tool results and checked against them; a person reviews it._
