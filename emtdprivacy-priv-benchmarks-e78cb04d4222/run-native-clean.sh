#!/bin/bash                                                                                        
BENCHMARK_HOME_DIR=./
BENCHMARK_DIRS="001.basicmath/bmk"

curDIR=$PWD

for dir in $BENCHMARK_DIRS; do
    cd $BENCHMARK_HOME_DIR/$dir
    ./run-native-clean.sh $CHURN_SLEEP_CYCLE | tee run-native-clean.out &
    cd $curDIR
done


