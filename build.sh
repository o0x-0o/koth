#!/usr/bin/env bash

set -x

CC="gcc"
CXX="g++"
ASM="nasm"

CHATTRBORKED_SOURCE2_PATCH=(
  "./3rd-party/Chattr-for-KOTH/chattr_borked.c"
  "./build/chattr_borked.c"
  "./patches/put_username_on_chattrborked.patch"
)

compile_chattr_borked() {
  echo "--- Compiling chattr_borked"
  cp -v ${CHATTRBORKED_SOURCE2_PATCH[0]} ${CHATTRBORKED_SOURCE2_PATCH[1]} || exit -1
  patch -np1 ${CHATTRBORKED_SOURCE2_PATCH[1]} < ${CHATTRBORKED_SOURCE2_PATCH[2]} || exit -1
  ${CC} ${CHATTRBORKED_SOURCE2_PATCH[1]} -o "./out/chattr" || exit -1
}

steps=(
  "compile_chattr_borked"
)

mkdir -pv build out

for step in "${steps[@]}"
do
  ${step}
done

set +x