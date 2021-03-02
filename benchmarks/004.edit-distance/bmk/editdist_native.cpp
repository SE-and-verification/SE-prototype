#include <iostream>
#include <string>
#include <vector>
#define MIN(x, y, z) (x < y && x < z ? x : y < z ? y : z)


using namespace std;

int editDistance(string str1, string str2);

vector<string> random_s = {"TTGCCGTT","TGTTATTC","CCGCATTG","GAGGCCTT","TTGCCGTC","CATAACTT","CAGGCCTG","GTCAGGTA","ATTTCGGT","TGCTGAAC","CACGTTGC","CCCCTGTT","GATGCCCG","CGCGAGTG","TGCAGCGA","TGTCGGTT","CGCAAGTT","TTAACCCG","TATTGTTC","ACCCCCGC","GCCTACCT","GAAATTAA","GGCTCCTT","GCGACTTT","GGTAGTCA","TATGCGTA","GGTACGCT","CACTGGGC","ATTGAGCC","GGGACGGG"};
vector<string> biased_s = {"AGATTAGA","CAGATAGT","GTAGTCCT","CGATATAA","GCCGTCGG","GTCCCAAC","AGTTGACA","TCGTCAAT","GGGGACTA","CAGATGCT","AGGCACAA","TAAGACAA","TCGATGTT","GAGTCTGA","CTTTTAAG","ACCGCCCG","TCTTGTGC","CGGTGTGC","ACAGTAGA","TGATATAG","CATACATA","CCCTAACT","ACACTACG","AGACGCAC","TCGCCATC","ATGCTTCT","CAATGCTA","TCGATATA","CCATGTTG","AATTGCAA"};

vector<string> biased_d = {"ATAGCTGAA","GGTTGTTC","ATGCATTT","TACCCTT","TATATCTGCAC","CATGCTC","CAGCCCC","GCACGGA","AATGGT","CGCTGCAAAA","CAGCGTAGC","CGGCTCTT","GTACGGGCG","CCGGACTG","GCACGACGT","GGGCGGTCT","TAGGGAGATC","TTACCG","ATTTACTC","AATCGCCAGT","GCCCCCCCT","AATATTTA","GACCTCT","GCTCTGG","GTAGATCG","TACCGT","GTAGC","CGTGGTGGC","TGGTAAGAC","GGGGAGGA"};

string empty = "";

void findDistanceWithinArray(vector<string> arr){
    int len = arr.size();
    for(int i = 0, j = len - 1 ; i < len/2; i++, j--){
        cout << "Distance between " + arr[i] + " ," + arr[j] +" : " << editDistance(arr[i], arr[j])<<endl;
    }
    cout<<endl;
} 

void findDistanceBetweenArray(vector<string> arr1, vector<string> arr2){
    int len = arr1.size();
    for(int i = 0 ; i < len ; i++){
        cout << "Distance between " + arr1[i] + " ," + arr2[i] +" : " << editDistance(arr1[i], arr2[i])<<endl; 
    }
    cout<<endl;
}

inline void checkForSameAndEmpty(){
    cout << "Distance between \"\" ," + random_s[0] +" : " << editDistance(empty, random_s[0])<<endl; 
    cout << "Distance between " + biased_s[0] + " ," + biased_s[0] +" : " << editDistance(biased_s[0], biased_s[0])<<endl; 

}


int editDistance(string str1, string str2){
    int dist = 0;
    if(str1.length() == 0){
        dist = str2.length();
    }
    else if(str2.length() == 0){
        dist = str1.length();
    }
    else{
        int edit_matrix[str1.length() + 1][str2.length() + 1];
        
        for (int i = 0; i < str1.length() + 1; i++ )
        {
            edit_matrix[i][0] = i;
        }

        for (int j = 0; j < str2.length() + 1; j++ )
        {
            edit_matrix[0][j] = j;
        }

        int i, j;
        for (i = 0; i < str1.length(); i++ )
        {
            for (j = 0; j < str2.length(); j++ )
            {
                int edit = 1;
                if(str1[i] == str2[j]){
                    edit = 0;
                }
                
                edit_matrix[i + 1][j + 1] = MIN( edit_matrix[i] [j + 1] + 1,
                edit_matrix[i + 1][j] + 1, edit_matrix[i] [j] + edit);
                //cout<<"Edit "<<(i+1)<<", "<< (j+1) << " : "<< edit_matrix[i+1][j+1]<< endl;
            }
            
        }
        dist = edit_matrix[str1.length()][str2.length()];
        
    }
    return dist;

}

int main() 
{ 

	/*string str1 = "intention"; 
	string str2 = "execution";  
    cout << "Distance: "<< editDistance(str2, str1)<< endl;*/


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

