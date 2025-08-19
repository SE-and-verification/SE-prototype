set_elaborate_single_run_mode off

analyze -sva assertions/SE_functional_abstract.sv assertions/fifo.sv
elaborate -top SE -bbox_a 16384 -bbox_m CompressionFunction -bbox_m SEOperation -bbox_m Sha256Accel -bbox_m seoperation -bbox_m AESMAC -bbox_m AESDecrypt -bbox_m AESDecrypt_1 -bbox_m AESEncrypt384 -bbox_m MaxPeriodFibonacciLFSR 

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

# These two events must not happen before mac starts, otherwise they will cause spurious cex
assume {se_finish==aes_cipher_for_op1_mac_validation_start}
assume {aes_cipher_io_input_valid==aes_cipher_for_op1_mac_validation_start}

# set stop to 1 in an arbitrary cycle
stopat stop_enable

assert -disable *
assert -enable *aes_cipher_for_op1_mac_validation*

set_engine_mode {Mp N Tri Ht}
prove -all