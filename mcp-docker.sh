#!/usr/bin/env bash
set -euo pipefail

service_name="sonarqube-mcp"
account_name="SONARQUBE_TOKEN"

export SONARQUBE_ORG="${SONARQUBE_ORG:-stefanbilliet}"
export SONARQUBE_URL="${SONARQUBE_URL:-https://sonarcloud.io}"

if [[ -z "${SONARQUBE_TOKEN:-}" ]]; then
  token="$({ security find-generic-password -s "$service_name" -a "$account_name" -w 2>/dev/null; } || true)"

  if [[ -z "$token" ]]; then
    printf 'Missing Keychain item: service=%s account=%s\n' "$service_name" "$account_name" >&2
    exit 1
  fi
  export SONARQUBE_TOKEN="$token"
fi

exec docker compose -f compose.mcp.yml up --build "$@" -d
