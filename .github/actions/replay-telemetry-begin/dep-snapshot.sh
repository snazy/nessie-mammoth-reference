#!/usr/bin/env bash
# Records file count and bytes of the writable Gradle dependency artifact cache.
set -euo pipefail
phase="$1"
dir="$2"
root="${HOME}/.gradle/caches/modules-2/files-2.1"
files=0
bytes=0
if [[ -d "${root}" ]]; then
  files=$(find "${root}" -type f | wc -l)
  bytes=$(du -sb "${root}" | cut -f1)
fi
mkdir -p "${dir}"
printf '{"phase":"%s","at":%s,"files":%s,"bytes":%s,"roDepCache":"%s"}\n' \
  "${phase}" "$(date +%s%3N)" "${files}" "${bytes}" "${GRADLE_RO_DEP_CACHE:-}" > "${dir}/deps-${phase}.json"
