#!/bin/bash

: ${GEM5_DIR:=~/privacy/priv-gem5}

CONFIG_FILE=$GEM5_DIR/configs/priv/priv-bmk/mapreduce-enc.py

ln -sf $GEM5_DIR/ext/ ./ext

$GEM5_DIR/build/X86/gem5.opt --debug-flags=Exec,csd --debug-file=debug.out --stats-file=stats.txt $CONFIG_FILE

mv m5out ../results/m5out-enc-priv
