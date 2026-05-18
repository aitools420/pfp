#!/usr/bin/env bash
# sync.sh — keep clones in sync with the root index.html.
#
# Why this exists:
#   pfp.wick.pics is on GitHub Pages, which can't do server-side URL rewrites.
#   To make /word URLs work without showing ?style=word in the address bar,
#   we serve the same app from multiple file paths:
#     - /index.html        → serves /
#     - /gold/index.html   → serves /gold/        (real directory, HTTP 200)
#     - /404.html          → SPA fallback for /wick /fire /ice /tang /pulse /hex
#                            and any other slug (HTTP 404 status, but the page
#                            renders normally and the URL stays intact)
#
#   The deep-link reader at index.html:395 picks the slug from location.pathname,
#   so the same source file works for all routes.
#
# Run this BEFORE every git push that touches index.html.
set -euo pipefail
cd "$(dirname "$0")"
cp index.html gold/index.html
cp index.html 404.html
echo "Synced: gold/index.html and 404.html are now identical to index.html"
