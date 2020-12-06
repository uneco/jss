#!/bin/bash

REPO="uneco/jss"
TARGET=$(pwd)

if [ -z "${B}" ]; then
  B=master
fi

LOCAL="${HOME}/.cache/${REPO}"
if [ -d "${LOCAL}" ]; then
  cd "${LOCAL}"
  git fetch && git reset --hard "origin/${B}"
else
  git clone -b "${B}" git@github.com:${REPO}.git "${LOCAL}"
fi

echo bash "${LOCAL}/profiles/${P}/install.sh"
cd "${TARGET}" && bash "${LOCAL}/profiles/${P}/install.sh"
