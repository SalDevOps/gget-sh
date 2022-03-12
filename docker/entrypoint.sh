#!/usr/bin/env bash
set -e

# Run command with gget in cases where the first argument:
# contains a "-" OR looks like a shorthand/url OR is not a system command.
if [[ "${1#-}" != "${1}" ]] || [[ "${1}" =~ (http)?.*/.* ]] || [[ -z "$(command -v "${1}")" ]]; then
  set -- gget "$@"
fi

exec "$@"