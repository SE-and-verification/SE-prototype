
/* +++Date last modified: 26-Oct-2020 */

/*
**        Levenshtein distance is a string metric for measuring the 
**  difference between two sequences.
**  the Levenshtein distance between two words is the minimum number 
**  of single-character edits (insertions, deletions or substitutions) required 
**  to change one word into the other. It is named after the Soviet mathematician 
**  Vladimir Levenshtein, who considered this distance in 1965.
**
**
*/

// This implementation is independent of the string size and operates on strings of 
// 32 characters max!

/* Command to run file:
$ g++ -std=c++11 editdist_enc_do.cpp -o editdist_enc_do ~/Privacy/functional-library/src/interface/parameters.cpp ~/Privacy/functional-library/src/ciphers/simon/Simon_Speck_Ciphers/C/simon.c ~/Privacy/functional-library/src/ciphers/aes/tinyCrypt_without_Git/lib/utils.o ~/Privacy/functional-library/src/ciphers/aes/tinyCrypt_without_Git/lib/aes_encrypt.o ~/Privacy/functional-library/src/ciphers/aes/tinyCrypt_without_Git/lib/aes_decrypt.o ~/Privacy/functional-library/src/rng/mersenne-twister-1/mersenne-twister.cpp


*/

#include <iostream>
#include <string>

#include "../../../functional-library/src/datatypes/enc_lib.h"
#include "../../../functional-library/src/datatypes/enc_string.h"
#include "../../../functional-library/src/interface/interface.h"
#include "../../../functional-library/src/interface/parameters.h"

//#include "../../../encrypted-datatype-library/src/datatypes/enc_lib.h"
//#include "../../../encrypted-datatype-library/src/datatypes/enc_string.h"

#define MIN(x, y, z) ((x < y).GET_DECRYPTED_VALUE() && (x < z).GET_DECRYPTED_VALUE() ? x : (y < z).GET_DECRYPTED_VALUE() ? y : z)

#define MAXLEN 32

#define PRINT_INPUTS true
#define PRINT_INTERMEDIATES false

using namespace enc_lib;
using namespace std;


enc_int editDistance(enc_string&, enc_string&);

vector<string> random_s = {"TTGCCGTT","TGTTATTC","CCGCATTG","GAGGCCTT","TTGCCGTC","CATAACTT","CAGGCCTG","GTCAGGTA","ATTTCGGT","TGCTGAAC","CACGTTGC","CCCCTGTT","GATGCCCG","CGCGAGTG","TGCAGCGA","TGTCGGTT","CGCAAGTT","TTAACCCG","TATTGTTC","ACCCCCGC","GCCTACCT","GAAATTAA","GGCTCCTT","GCGACTTT","GGTAGTCA","TATGCGTA","GGTACGCT","CACTGGGC","ATTGAGCC","GGGACGGG"};
vector<string> biased_s = {"AGATTAGA","CAGATAGT","GTAGTCCT","CGATATAA","GCCGTCGG","GTCCCAAC","AGTTGACA","TCGTCAAT","GGGGACTA","CAGATGCT","AGGCACAA","TAAGACAA","TCGATGTT","GAGTCTGA","CTTTTAAG","ACCGCCCG","TCTTGTGC","CGGTGTGC","ACAGTAGA","TGATATAG","CATACATA","CCCTAACT","ACACTACG","AGACGCAC","TCGCCATC","ATGCTTCT","CAATGCTA","TCGATATA","CCATGTTG","AATTGCAA"};

vector<string> biased_d = {"ATAGCTGAA","GGTTGTTC","ATGCATTT","TACCCTT","TATATCTGCAC","CATGCTC","CAGCCCC","GCACGGA","AATGGT","CGCTGCAAAA","CAGCGTAGC","CGGCTCTT","GTACGGGCG","CCGGACTG","GCACGACGT","GGGCGGTCT","TAGGGAGATC","TTACCG","ATTTACTC","AATCGCCAGT","GCCCCCCCT","AATATTTA","GACCTCT","GCTCTGG","GTAGATCG","TACCGT","GTAGC","CGTGGTGGC","TGGTAAGAC","GGGGAGGA"};
bool is_header_printed = false;
bool is_last = false;
bool is_first = true;


void print_test_header(int len){
    string spec = "#==================================================================\n" 
    "# generator mt19937  seed = 3022359314\n"
    "#==================================================================\n";
    cout<<spec <<"type: d\ncount: " <<to_string(len) <<
        "\nnumbit: 32\n";

}

void print_string(enc_string &s){
    for (size_t i = 0; i < MAXLEN; i++)
    {
        bool is_last = (i == MAXLEN - 1) ? true : false;
        s[i].ciphertext.print_parted_32(is_last);
    }

}

void print_intermediates(enc_int (&edit_matrix)[MAXLEN + 1][MAXLEN + 1]){
    if(PRINT_INTERMEDIATES){
        if(!is_header_printed){
            //32M is just a dummy number, but this should be substituted by the exact number of test cases
            print_test_header(32000000);
            is_header_printed = true;
        }
        if(!is_first){
            cout<<endl;
        }
        for (size_t i = 0; i < MAXLEN+1; i++)
        {
            for (size_t j = 0; j < MAXLEN+1; j++)
            {
                bool is_last_val = (i == MAXLEN && j == MAXLEN) ? true : false;
                edit_matrix[i][j].ciphertext.print_parted_32(is_last_val);
            }
            
        }
    }    

}

void print_inputs(enc_string &str1 , enc_string& str2){
    if(PRINT_INPUTS){
        if(!is_header_printed){
            //32M is just a dummy number, but this should be substituted by the exact number of test cases
            print_test_header(32000000);
            is_header_printed = true;
        }
        
        print_string(str1);
        cout<<endl;
        print_string(str2);
        if(!is_last){
            cout<<endl;
        }
    }
}

inline void printResult(string& str1, string& str2, enc_int& result){
    if(str1 == ""){
        str1 = "\"\"";
    }
    if(str2 == ""){
        str2 = "\"\"";
    }
    string printStmt =  (PRINT_INPUTS || PRINT_INTERMEDIATES)? "":"Distance between " + str1 + " ," + str2 +" : " + to_string(result.GET_DECRYPTED_VALUE()) + "\n";
    cout << printStmt;
}

void findDistanceWithinArray(vector<string>& arr){
    int len = arr.size();
    for(int i = 0, j = len - 1 ; i < len/2; i++, j--){
        enc_string x = arr[i];
        enc_string y = arr[j];
        enc_int result = editDistance(x, y).ciphertext;
        printResult(arr[i], arr[j], result);  
    }
    //cout<<endl;
} 

void findDistanceBetweenArray(vector<string>& arr1, vector<string>& arr2){
    int len = arr1.size();
    for(int i = 0 ; i < len ; i++){
        enc_string x = arr1[i];
        enc_string y = arr2[i];
        enc_int result = editDistance(x, y).ciphertext;
        printResult(arr1[i], arr2[i], result);
    
    }
    //cout<<endl;
}

inline void checkForSameAndEmpty(){
    enc_string random = random_s[0];
    enc_string biased = biased_s[0];
    enc_string empty = "";
    string empty_str = "";
    enc_int result_1 = editDistance(empty, random).ciphertext;
    is_last = true;
    enc_int result_2 = editDistance(biased, biased).ciphertext;
    //cout << "Distance between \"\"," + random_s[0] +" : " << editDistance(empty, random).GET_DECRYPTED_VALUE()<<endl; 
    //cout << "Distance between " + biased_s[0] + " ," + biased_s[0] +" : " << editDistance(biased, biased).GET_DECRYPTED_VALUE()<<endl; 
    printResult(empty_str, random_s[0], result_1);
    printResult(biased_s[0], biased_s[0], result_2);

}


enc_int editDistance(enc_string& str1, enc_string& str2){
    print_inputs(str1, str2);
    
    enc_int edit_matrix[MAXLEN + 1][MAXLEN + 1];
    for (int i = 1; i < MAXLEN + 1; i++ )
    {
        edit_matrix[i][0] = (str1[i-1].GET_DECRYPTED_VALUE() != '\0')? i : -1;
    }
    for (int j = 1; j < MAXLEN + 1; j++ )
    {
        edit_matrix[0][j] = (str2[j-1].GET_DECRYPTED_VALUE() != '\0')? j : -1;
    }

    int i, j;
    enc_int str1_size = str1.size();
    enc_int str2_size = str2.size();
    enc_bool is_str_empty = str1.empty(); 
    enc_int dist = (is_str_empty.GET_DECRYPTED_VALUE()) ? str2_size.GET_DECRYPTED_VALUE() : str1_size.GET_DECRYPTED_VALUE();
    for (i = 0; i < MAXLEN; i++ )
    {
        for (j = 0; j < MAXLEN; j++ )
        {
            int edit = (str1[i] == str2[j]).GET_DECRYPTED_VALUE() ? 0 : 1;
            edit_matrix[i+1][j+1] = MIN( edit_matrix[i] [j+1] + 1, edit_matrix[i+1][j] + 1, edit_matrix[i] [j] + edit).GET_DECRYPTED_VALUE();
            dist = (str1[i].GET_DECRYPTED_VALUE() == '\0' || str2[j].GET_DECRYPTED_VALUE() == '\0') ? dist.GET_DECRYPTED_VALUE() : edit_matrix[i+1][j+1];
        }
    }

    print_intermediates(edit_matrix);
    is_first = false;

    return dist;

}

int main() 
{ 
    // Setting up enc-dec env't
    //setParameters(SymmCipher::XOR, 0x0505050505050505, 0x0505050505050505, 0);
    setParameters(SymmCipher::AES128, 0x0505050505050505, 0x0505050505050505, 3022359314);


    //cout<<"------Within the randoms array------"<<endl;
    findDistanceWithinArray(random_s);
    //cout<<"------Between random array and biased array (sequences of the same length)------"<<endl;
    findDistanceBetweenArray(random_s, biased_s);
    //cout<<"------Between random array and biased array (sequences of the different length)------"<<endl;
    findDistanceBetweenArray(random_s, biased_d);
    //cout<<"------check for same and empty sequences------"<<endl;
    checkForSameAndEmpty();
    


    return 0; 
}
