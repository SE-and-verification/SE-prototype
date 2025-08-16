#check_spv -init
analyze -sva ./SE_rolled.v
elaborate -top SE -bbox_mul 256

clock clock
reset reset -non_resettable_regs 0

#check_spv -create -from {seoperation_io_op1_input seoperation_io_op2_input seoperation_io_cond_input} -to aes_cipher_io_output_valid
#check_spv -create -from {seoperation_io_op1_input seoperation_io_op2_input seoperation_io_cond_input} -to result_change 
