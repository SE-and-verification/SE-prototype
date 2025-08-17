set_elaborate_single_run_mode off

analyze -sva assertions/SE_functional.sv assertions/fifo.sv
elaborate -top SE -bbox_a 16384

clock clock
reset reset -non_resettable_regs 0

assume {io_out_ready}

# blackbox data output of submodules
stopat seoperation.io_result
stopat aes_invcipher_op1.io_output_text
stopat aes_invcipher_op2.io_output_text
stopat aes_cipher_for_op1_mac_validation.io_output_text
stopat aes_cipher_for_op2_mac_validation.io_output_text
stopat aes_cipher_for_output_mac.io_output_text
stopat sha256_for_dataflow.io_outputData*
stopat aes_cipher.io_output_text
stopat bit64_randnum_prng.io_out*

# set stop to 1 in an arbitrary cycle
stopat stop_enable

set_engine_mode {Mp N Tri Ht}
prove -all