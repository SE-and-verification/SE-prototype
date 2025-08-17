set_elaborate_single_run_mode off
check_spv -init

analyze -sva assertions/SE.v
elaborate -top SE

clock clock
reset reset -non_resettable_regs 0

// Declassification
stopat aes_cipher_io_output_text
assume {!aes_cipher_io_output_valid |-> (aes_cipher_io_output_text==aes_cipher.io_output_text)}

// Information Flow Properties
check_spv -create -from {aes_invcipher_op1_io_output_text aes_invcipher_op2_io_output_text }

set_engine_mode {Mp N AM Ht}
prove -all