#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# gh-pages deploy
# @author Hung Nguyen
# @since 2023/07/07
# ------------------------------------------------------------------------------

# Enter root directory
ROOT_DIR=$(
  cd $(dirname $0)/..
  pwd
)

set -e

# build
npm run build

# go to build dir
cd ${ROOT_DIR}/docs/.vuepress/dist

# add cname if needed
# echo 'www.example.com' > CNAME

if [[ ${GITHUB_TOKEN} ]]; then
  msg='auto deploy'
  GITHUB_URL=https://vanhung4499:${GITHUB_TOKEN}@github.com/vanhung4499/base-doc.git
  git config --global user.name "Hung Nguyen"
  git config --global user.email "vanhung4499@gmail.com"
else
  msg='manual deploy'
  GITHUB_URL=git@github.com/vanhung4499/base-doc.git
fi

git init
git add -A
git commit -m "${msg}"
# Push to gh-pages branch in github
git push -f "${GITHUB_URL}" master:gh-pages

# Clean
cd -
rm -rf ${ROOT_DIR}/docs/.vuepress/dist
