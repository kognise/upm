#!/usr/bin/env bash

set -e
set -o pipefail

# Each loop iteration sleeps for 100ms, so this means an overall
# timeout of 5s.
for i in $(seq 50); do
    if curl -s localhost:6060 >/dev/null; then
        # Give some extra time for godoc to complete the initial scan.
        sleep 0.2
        url="http://localhost:6060/pkg/github.com/replit/upm/"
        if command -v xdg-open &>/dev/null; then
            echo "godoc started; opening with xdg-open(1)" >&2
            xdg-open "$url"
        elif command -v open &>/dev/null; then
            echo "godoc started; opening with open(1)" >&2
            open "$url"
        else
            echo "please install either open(1) or xdg-open(1)" >&2
            exit 1
        fi
        exit 1
    fi
    sleep 0.1
done

echo "godoc failed to start listening on port 6060" >&2
exit 1