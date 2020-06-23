#!/bin/sh

set -e

echo "Hello World"
echo ${GITHUB_PAT}
echo ${TRAVIS_BRANCH}
echo ${TRAVIS_REPO_SLUG}

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "jordans1882@gmail.com"
git config --global user.name "Jordan Schupbach"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git site-output
cd site-output
cp -r ../_site/* ./
git add --all *
git commit -m "Deploy update of the site" || true
git push -q origin gh-pages

