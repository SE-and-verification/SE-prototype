#check_spv -init
analyze -sva ./SE_opt.v


elaborate -top SE -bbox_mul 256


clock clock
reset reset -non_resettable_regs 0

#check_spv -create -from {seoperation_io_op1_input seoperation_io_op2_input seoperation_io_cond_input} -to result_change 
#assert {@(posedge clock) disable iff (reset) se_origin.result_change == se_changed.result_change}
