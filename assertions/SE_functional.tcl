set_elaborate_single_run_mode off

analyze -sva assertions/SE_functional.sv assertions/fifo.sv
elaborate -top SE -bbox_a 16384

clock clock
reset reset -non_resettable_regs 0

set_engine_mode {Mp N AM Ht}
prove -all