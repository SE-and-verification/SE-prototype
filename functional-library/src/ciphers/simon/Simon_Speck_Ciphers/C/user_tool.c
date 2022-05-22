//
// Created by Calvin McCoy on 9/2/17.
//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "string.h"

#include "cipher_constants.h"
#include "simon.h"
#include "speck.h"


/* Usage
 $ ./user simon_256_128 ECB -e keyfile input output
*/

#define SIMON 0
#define SPECK 1
#define ENCRYPT 0
#define DECRYPT 1

#ifndef VERSION
#define VERSION "custom_build"
#endif

const static struct {
    const char *str;
    uint8_t     index;
    uint8_t     cipher;
} valid_cfgs [] = {
        {"simon_64_32", 0, SIMON},
        {"simon_72_48", 1, SIMON},
        {"simon_96_48", 2, SIMON},
        {"simon_96_64", 3, SIMON},
        {"simon_128_64", 4, SIMON},
        {"simon_96_96", 5, SIMON},
        {"simon_144_96", 6, SIMON},
        {"simon_128_128", 7, SIMON},
        {"simon_192_128", 8, SIMON},
        {"simon_256_128", 9, SIMON},
        {"speck_64_32", 0, SPECK},
        {"speck_72_48", 1, SPECK},
        {"speck_96_48", 2, SPECK},
        {"speck_96_64", 3, SPECK},
        {"speck_128_64", 4, SPECK},
        {"speck_96_96", 5, SPECK},
        {"speck_144_96", 6, SPECK},
        {"speck_128_128", 7, SPECK},
        {"speck_192_128", 8, SPECK},
        {"speck_256_128", 9, SPECK}
};

void print_usage(void);


int main(int argc, char *argv[]) {

    /* Test That The Minumum Number of Arguments are Provided */
    if (argc < 6) {
        fprintf(stderr, "Missing All Required Inputs!!\n");
        print_usage();
        return -1;
    }

    uint8_t cfg_index = 255;
    uint8_t cfg_cipher = SIMON;
    uint8_t cfg_dir;

    for (int j = 0;  j < sizeof (valid_cfgs) / sizeof (valid_cfgs[0]);  ++j) {
        if (!strcmp(argv[1], valid_cfgs[j].str)) {
            cfg_index = valid_cfgs[j].index;
            cfg_cipher = valid_cfgs[j].cipher;
            break;
        }
    }
    if (255 == cfg_index) {
        fprintf(stderr, "Not a Valid Simon/Speck Cipher Configuration");
        return -1;
    }

    const uint16_t key_size_bits = key_sizes[cfg_index];
    const uint8_t block_size_bits = block_sizes[cfg_index];
    const uint8_t  block_size = block_size_bits >> 3;


    // Set Cipher Direction: -e -> Encrypt, -d -> Decrypt
    if (!strncmp(argv[3], "-e", 2)) cfg_dir = ENCRYPT;
    else if (!strncmp(argv[3], "-d", 2)) cfg_dir = DECRYPT;
    else {
        fprintf(stderr, "Can Only Encrypt or Decrypt");
        return -1;
    }

    uint8_t (*initPtr)(SimSpk_Cipher *, enum cipher_config_t, enum mode_t, void *, uint8_t *, uint8_t *);
    uint8_t (*operationPtr)(SimSpk_Cipher, const void *, void *);

    if (SIMON == cfg_cipher) {
        initPtr = &Simon_Init;
        if (ENCRYPT == cfg_dir) operationPtr = &Simon_Encrypt;
        else operationPtr = &Simon_Decrypt;
    }
    else {
        initPtr = &Speck_Init;
        if (ENCRYPT == cfg_dir) operationPtr = &Speck_Encrypt;
        else operationPtr = &Speck_Decrypt;
    }


    // Read In Key Bytes
    FILE *key_fd;
    key_fd = fopen(argv[4],"rb");
    fseek(key_fd, 0L, SEEK_END);
    size_t key_file_size = (size_t)ftell(key_fd);
    size_t  key_size = key_size_bits >> 3;
    printf("Key File Size (Bits): %zu\n", key_file_size*8);
    if (key_size > key_file_size) {
        fprintf(stderr, "Insufficient Key Bytes! Found:%zu  Need %zu\n", key_file_size, key_size);
        return -1;
    }
    rewind(key_fd);
    uint8_t *key_buffer = malloc((size_t)key_size);
    fread(key_buffer, 1, key_size, key_fd);
    fclose(key_fd);


    // Read in Input Data to Allocated Array
    FILE *in_fd;
    in_fd = fopen(argv[5],"rb");
    fseek(in_fd, 0L, SEEK_END);
    size_t input_size = (size_t)ftell(in_fd);
    printf("File Size: %zX\n", input_size);
    rewind(in_fd);
    uint8_t *working_buffer = malloc((size_t)input_size);
    fread(working_buffer, 1, input_size, in_fd);
    fclose(in_fd);

    SimSpk_Cipher my_cipher;
    int result = (*initPtr)(&my_cipher, (enum cipher_config_t)cfg_index, ECB, key_buffer, NULL, NULL);
    if (result) {
        fprintf(stderr, "Failed to Init Cipher\n");
        return result;
    }
    printf("Key Size: %d\n", my_cipher.key_size);
    printf("Block Size: %d\n", my_cipher.block_size);

    uint8_t *backup_buffer = working_buffer;
    for(int block=0; block < input_size / block_size; block++){
        (*operationPtr)(my_cipher, working_buffer, working_buffer);
        working_buffer += block_size;
    }

    FILE *out_fd;
    out_fd = fopen(argv[6],"wb");
    fwrite(backup_buffer, 1, input_size, out_fd);
    fclose(out_fd);

    /* Free ALl Buffers */
    free(key_buffer);
    free(backup_buffer);
    printf("All done!\n");
    return  0;
}


void print_usage(void){
    printf("Simon/Speck User Tool\n");
    printf("Version: %s\n", VERSION);
    printf("usage: user <CIPHER_CONFIGURATION> <BLOCK_MODE> <CIPHER_DIRECTION> <KEYFILE> <INPUT_FILE> <OUTPUT>\n");
}
