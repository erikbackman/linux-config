#!/bin/sh
notmuch search --format=text0 --output=files tag:deleted | xargs -p -0 --no-run-if-empty rm
notmuch new 1&>/dev/null
