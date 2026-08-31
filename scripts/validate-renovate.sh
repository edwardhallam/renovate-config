#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "${root}"

validate_steward_boundary() {
  local config_path="$1"
  jq -e '
    .minimumReleaseAge == "14 days" and
    .internalChecksFilter == "strict" and
    ((.platformAutomerge // false) == false) and
    ((.automerge // false) == false) and
    (.extends | index("helpers:pinGitHubActionDigestsToSemver") != null) and
    ([.packageRules[]? | select(.automerge == true)] | length == 0) and
    .vulnerabilityAlerts.automerge == false
  ' "${config_path}" >/dev/null || {
    printf 'steward boundary invalid: %s\n' "${config_path}" >&2
    return 1
  }
}

validate_steward_boundary default.json
validate_steward_boundary renovate.json

boundary_fixture="$(mktemp)"
trap 'rm -f "${boundary_fixture}"' EXIT
jq '.automerge = true' default.json > "${boundary_fixture}"
if validate_steward_boundary "${boundary_fixture}" 2>/dev/null; then
  printf 'steward boundary regression: top-level automerge=true was accepted\n' >&2
  exit 1
fi
rm -f "${boundary_fixture}"
trap - EXIT

npx --yes -p renovate renovate-config-validator default.json
npx --yes -p renovate renovate-config-validator renovate.json
