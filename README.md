# renovate-config

Shared Renovate preset for `edwardhallam/*` repositories.

`default.json` is the preset consumed by other repos with:

```json
{
  "extends": ["local>edwardhallam/renovate-config"]
}
```

This repo has its own `renovate.json` and intentionally does not extend the shared preset. That avoids self-reference while still letting Renovate maintain this repo's GitHub Actions workflow dependencies with the same 7-day release-age and CI-gated automerge posture.

Validate changes before merging:

```bash
npx --yes -p renovate renovate-config-validator default.json
npx --yes -p renovate renovate-config-validator renovate.json
```
