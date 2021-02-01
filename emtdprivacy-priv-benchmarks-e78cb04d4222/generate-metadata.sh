#!/bin/bash                                                                                        

#TODO Update from Morpheus metadata stuff... needs to use taint tracking :)

BENCHMARK_HOME_DIR=./
RUN_SCRIPT_DIRS="001.basicmath/bmk"

curDIR=$PWD

for dir in $RUN_SCRIPT_DIRS; do
    cd $BENCHMARK_HOME_DIR/$dir
    $PYPY_EMTD -m emtd_labels_parser $(ls *_s) > "$(ls *_s)".metadata.str
    cd $curDIR
done


