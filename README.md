# renovate-config

Shared Renovate preset for `edwardhallam/*` repositories.

`default.json` is the preset consumed by other repos with:

```json
{
  "extends": ["local>edwardhallam/renovate-config"]
}
```

This repo has its own `renovate.json` and intentionally does not extend the shared preset. That avoids self-reference while still letting Renovate maintain this repo's GitHub Actions workflow dependencies with the same 7-day release-age and CI-gated automerge posture.

## Operations Classification

- Repo type: config-control-plane
- Template baseline: `config-control-plane-v1`
- Consumed by: `edwardhallam/*` repos using `local>edwardhallam/renovate-config`
- CI required check: `validate-renovate`
- Failure notification: `CI Failure Email` via Resend
- Renovate policy: `default.json` for downstream repos; `renovate.json` for self-maintenance
- Deployment status: consumed configuration, no runtime deploy
- Public visibility: public-safe configuration repo

Validate changes before merging:

```bash
scripts/validate-renovate.sh
```
