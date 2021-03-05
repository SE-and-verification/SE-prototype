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

/* Command to run file:
 $ g++ -std=c++11 editdist_enc.cpp -o editdist_enc ~/Privacy/functional-library/src/interface/parameters.cpp 
*/

#include <iostream>
#include <string>
#include <vector>

#include "../../../functional-library/src/datatypes/enc_lib.h"
#include "../../../functional-library/src/datatypes/enc_string.h"
#include "../../../functional-library/src/interface/interface.h"
#include "../../../functional-library/src/interface/parameters.h"

//#include "../../../encrypted-datatype-library/src/datatypes/enc_lib.h"
//#include "../../../encrypted-datatype-library/src/datatypes/enc_string.h"

#define MIN(x, y, z) ((x < y) && (x < z) ? x : (y < z) ? y : z)


using namespace enc_lib;
using namespace std;

enc_int editDistance(enc_string<10>, enc_string<10>);

vector<string> random_s = {"TTGCCGTT","TGTTATTC","CCGCATTG","GAGGCCTT","TTGCCGTC","CATAACTT","CAGGCCTG","GTCAGGTA","ATTTCGGT","TGCTGAAC","CACGTTGC","CCCCTGTT","GATGCCCG","CGCGAGTG","TGCAGCGA","TGTCGGTT","CGCAAGTT","TTAACCCG","TATTGTTC","ACCCCCGC","GCCTACCT","GAAATTAA","GGCTCCTT","GCGACTTT","GGTAGTCA","TATGCGTA","GGTACGCT","CACTGGGC","ATTGAGCC","GGGACGGG"};
vector<string> biased_s = {"AGATTAGA","CAGATAGT","GTAGTCCT","CGATATAA","GCCGTCGG","GTCCCAAC","AGTTGACA","TCGTCAAT","GGGGACTA","CAGATGCT","AGGCACAA","TAAGACAA","TCGATGTT","GAGTCTGA","CTTTTAAG","ACCGCCCG","TCTTGTGC","CGGTGTGC","ACAGTAGA","TGATATAG","CATACATA","CCCTAACT","ACACTACG","AGACGCAC","TCGCCATC","ATGCTTCT","CAATGCTA","TCGATATA","CCATGTTG","AATTGCAA"};

vector<string> biased_d = {"ATAGCTGAA","GGTTGTTC","ATGCATTT","TACCCTT","TATATCTGCAC","CATGCTC","CAGCCCC","GCACGGA","AATGGT","CGCTGCAAAA","CAGCGTAGC","CGGCTCTT","GTACGGGCG","CCGGACTG","GCACGACGT","GGGCGGTCT","TAGGGAGATC","TTACCG","ATTTACTC","AATCGCCAGT","GCCCCCCCT","AATATTTA","GACCTCT","GCTCTGG","GTAGATCG","TACCGT","GTAGC","CGTGGTGGC","TGGTAAGAC","GGGGAGGA"};


void findDistanceWithinArray(vector<string> arr){
    int len = arr.size();
    for(int i = 0, j = len - 1 ; i < len/2; i++, j--){
        enc_string<10> x = enc_string<10>(arr[i].c_str());
        enc_string<10> y =  enc_string<10>(arr[j].c_str());
        cout << "Distance between " + arr[i] + " ," + arr[j] +" : " << editDistance(x, y)<<endl;
    }
    cout<<endl;
} 

void findDistanceBetweenArray(vector<string> arr1, vector<string> arr2){
    int len = arr1.size();
    for(int i = 0 ; i < len ; i++){
        enc_string<10> x = enc_string<10>(arr1[i].c_str());
        enc_string<10> y = enc_string<10>(arr2[i].c_str());
        cout << "Distance between " + arr1[i] + " ," + arr2[i] +" : " << editDistance(x, y)<<endl; 
    }
    cout<<endl;
}

inline void checkForSameAndEmpty(){
    enc_string<10> empty = "";
    enc_string<10> random = enc_string<10>(random_s[0].c_str());
    enc_string<10> biased = enc_string<10>(biased_s[0].c_str());
    cout << "Distance between \"\" ," + random_s[0] +" : " << editDistance(empty, random)<<endl; 
    cout << "Distance between " + biased_s[0] + " ," + biased_s[0] +" : " << editDistance(biased, biased)<<endl; 

}

enc_int editDistance(enc_string<10> str1, enc_string<10> str2){
    enc_int dist = 0;
    if(str1.size() == 0){
        dist = str2.size();
    }
    else if(str2.size() == 0){
        dist = str1.size();
    }
    else{
        enc_int edit_matrix[str1.size() + 1][str2.size() + 1];
        
        for (int i = 0; (i < str1.size() + 1); i++ )
        {
            edit_matrix[i][0] = i;
        }

        for (int j = 0; (j < str2.size() + 1); j++ )
        {
            edit_matrix[0][j] = j;
        }

        int i, j;
        for (i = 0; (i < str1.size()); i++ )
        {
            for (j = 0; (j < str2.size()); j++ )
            {
                int edit = 1;
                if((str1[i] == str2[j])){
                    edit = 0;
                }
                
                edit_matrix[i + 1][j + 1] = MIN( edit_matrix[i] [j + 1] + 1,
                edit_matrix[i + 1][j] + 1, edit_matrix[i] [j] + edit);
            }
            
        }
        dist = edit_matrix[str1.size()][str2.size()];

    }
    return dist;

}

int main() 
{ 
    
    setParameters();

    // Result must be 0
	enc_string str1 = "bat"; 
	enc_string str2 = "bat";
    cout << "Distance 1: "<< editDistance(str2, str1)<< endl; 

    // Result must be 2
    enc_string str3 = "b"; 
	enc_string str4 = "bat";
    cout << "Distance 2: "<< editDistance(str3, str4)<< endl;

    // Result must be 3
    enc_string str5 = ""; 
	enc_string str6 = "bat";
    cout << "Distance 3-1: "<< editDistance(str5, str6)<< "   "; 
    cout << "Distance 3-2: "<< editDistance(str6, str5)<< endl; 

    // Result must be 0
    enc_string str7 = ""; 
	enc_string str8 = "";
	cout << "Distance 4: "<< editDistance(str7, str8)<< endl; 

    // Result must be 5
    enc_string str9 = "intention"; 
	enc_string str10 = "execution";
	cout << "Distance 5: "<< editDistance(str9, str10)<< endl;


    cout<<"------Within the randoms array------"<<endl;
    findDistanceWithinArray(random_s);
    cout<<"------Between random array and biased array (sequences of the same length)------"<<endl;
    findDistanceBetweenArray(random_s, biased_s);
    cout<<"------Between random array and biased array (sequences of the different length)------"<<endl;
    findDistanceBetweenArray(random_s, biased_d);
    cout<<"------check for same and empty sequences------"<<endl;
    checkForSameAndEmpty();

    

	return 0; 
} 


