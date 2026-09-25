#!/bin/zsh
set -euo pipefail

repo_root=${0:A:h:h}
source_file="$repo_root/Shuttle/AppDelegate.m"
allowlist=$(sed -n 's/.*NSArray \*validSchemes = @\[\(.*\)\];.*/\1/p' "$source_file")

if [[ -z "$allowlist" ]]; then
  print -u2 'FAIL: validSchemes allowlist not found'
  exit 1
fi

for scheme in http https ftp file ssh telnet vnc; do
  if [[ "$allowlist" != *"@\"$scheme\""* ]]; then
    print -u2 "FAIL: missing required URL scheme: $scheme"
    exit 1
  fi
done

if [[ "$allowlist" == *'@"javascript"'* ]]; then
  print -u2 'FAIL: unsafe URL scheme unexpectedly allowed'
  exit 1
fi

print 'PASS: URL scheme allowlist includes vnc and excludes javascript'
