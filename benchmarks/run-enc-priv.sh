#!/bin/bash                                                                                        
BENCHMARK_HOME_DIR=./
BENCHMARK_DIRS="001.basicmath/bmk"

curDIR=$PWD

for dir in $BENCHMARK_DIRS; do
    cd $BENCHMARK_HOME_DIR/$dir
    ./run-enc-priv.sh $CHURN_SLEEP_CYCLE | tee run-enc-priv.out &
    cd $curDIR
done


