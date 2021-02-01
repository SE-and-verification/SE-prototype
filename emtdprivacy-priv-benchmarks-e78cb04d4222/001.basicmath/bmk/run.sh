#!/bin/bash

gem5=${gem5:-clean} #clean, priv
version=${version:-native} #native, enc, enc-do

while [ $# -gt 0 ]; do
  case "$1" in
    --gem5=*)
      gem5="${1#*=}"
      ;;
    --version=*)
      version="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done


: ${GEM5_DIR:=~/privacy/$gem5-gem5}

CONFIG_FILE=$GEM5_DIR/configs/priv/priv-bmk/001.basicmath-$version.py

ln -sf $GEM5_DIR/ext/ ./ext

$GEM5_DIR/build/X86/gem5.opt --debug-flags=Exec --debug-file=debug.out --stats-file=stats.txt $CONFIG_FILE

mv m5out ../results/m5out-$gem5-$version
