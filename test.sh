#!/bin/sh

LYCHEE_ARGS="--github-token $GITHUB_TOKEN"
LYCHEE_ARGS="${LYCHEE_ARGS} --max-concurrency 64"
LYCHEE_ARGS="${LYCHEE_ARGS} --verbose"
LYCHEE_ARGS="${LYCHEE_ARGS} --no-progress"
LYCHEE_ARGS="${LYCHEE_ARGS} './*.md' './_site/**/*.html'"

ADDED_KBARTICLES=$(echo "${ADDED_FILES}" | grep _kbarticles | xargs basename | cut -f 1 -d '.')
for article in $ADDED_KBARTICLES; do
    echo "addding $article to be excluded by link checker"
    LYCHEE_ARGS="${LYCHEE_ARGS} --exclude ${article}"
done

echo "lychee args: ${LYCHEE_ARGS}"

if [ -n "${GITHUB_ENV}" ]; then
    echo "LYCHEE_ARGS=${LYCHEE_ARGS}" >> "${GITHUB_ENV}"
fi