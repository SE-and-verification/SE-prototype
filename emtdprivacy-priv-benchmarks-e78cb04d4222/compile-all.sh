#!/bin/bash

RUN_SCRIPT_DIRS_1="./001.basicmath/bmk"
RUN_SCRIPT_DIRS_2=""

PARALLEL_CMD="cd {} && ./compile.sh"

parallel $PARALLEL_CMD ::: $RUN_SCRIPT_DIRS_1

parallel $PARALLEL_CMD ::: $RUN_SCRIPT_DIRS_2

