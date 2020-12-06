#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
PACKAGES=$(cat "${SCRIPT_DIR}/packages.txt")

cp -n "${SCRIPT_DIR}/.eslintrc.yml" .
cp "${SCRIPT_DIR}/.eslintrc.base.yml" .

touch .eslintignore
MERGED_IGNORE=$(cat "${SCRIPT_DIR}/.eslintignore" ".eslintignore" | sort | uniq)
echo "${MERGED_IGNORE}" > .eslintignore

cp -n "${SCRIPT_DIR}/tsconfig.json" .
cp "${SCRIPT_DIR}/tsconfig.base.json" .

mkdir -p .vscode
cp -n "${SCRIPT_DIR}/.vscode/launch.json" .vscode/launch.json

cp -n "${SCRIPT_DIR}/.editorconfig" .

if [ -e ./package-lock.json ]; then
  npm install --save-dev $PACKAGES
else
  if [ ! -e ./package.json ]; then
    yarn init -y
  fi
  yarn add -D $PACKAGES
fi
