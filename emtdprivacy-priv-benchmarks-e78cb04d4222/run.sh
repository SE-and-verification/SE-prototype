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


#!/bin/bash
BENCHMARK_HOME_DIR=./
BENCHMARK_DIRS="001.basicmath/bmk"

curDIR=$PWD

for dir in $BENCHMARK_DIRS; do
    cd $BENCHMARK_HOME_DIR/$dir
    ./run.sh --gem5=$gem5 --version=$version | tee run-$gem5-$version.out &
    cd $curDIR
done

