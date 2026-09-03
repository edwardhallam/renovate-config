# renovate-config

Shared Renovate preset for `edwardhallam/*` repositories.

`default.json` is the preset consumed by other repos with:

```json
{
  "extends": ["local>edwardhallam/renovate-config"]
}
```

This repo has its own `renovate.json` and intentionally does not extend the shared preset. That avoids self-reference while still letting Renovate maintain this repo's GitHub Actions workflow dependencies under the same 14-day release-age and immutable-action posture.

Renovate creates and updates PRs but is not the merge authority. The external
Renovate steward owns automatic merge/reject decisions after its independent
14-day release/first-seen gate, required checks, provenance, and risk review.
Renovate-native age exceptions for Docker digests, pins, replacements, lockfile
maintenance, and vulnerability PR creation never grant a merge exception.

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

Platform-native automerge is deliberately disabled in the shared preset.
Renovate automerge is also disabled. The external steward is the sole merge
decision-maker and independently revalidates the 14-day gate, exact required
checks, head SHA, and repository policy so neither a native age exception nor
an incomplete branch-protection rule can grant merge authority.

Before ending a quiescent rollout, resolve this preset from at least one pnpm
consumer and one Compose consumer and verify the effective configuration keeps
top-level and package-rule automerge disabled, the 14-day age gate enabled, and
GitHub Actions digest-pinned. Local source validation does not replace that
consumer readback.
