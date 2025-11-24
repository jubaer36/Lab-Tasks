#include<iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <numeric>

using namespace std;
float percentage(int val){
    return float(val)/100;
}
int element(int val);
int main(){
    int val = 88, n = 5;
    vector<int>scores;
    for(int i = 0 ; i < n ;i++){
        scores.push_back(val);
        val+=70;

    }
    sort(scores.begin(),scores.end());
    cout << "First value greater than 90: ";
    cout <<*upper_bound(scores.begin(),scores.end(),90)<< endl;
    cout << "Count of 88: ";
    cout <<count(scores.begin(),scores.end(),88)<< endl;
    vector<int>scores2 = {4,2,59,42,54};
    cout << "Equal Vectors : ";
    if(equal(scores.begin(),scores.end(),scores2.begin(),scores2.end())){
        cout << "Equal" << endl;
    }
    else cout << "Not Equal" << endl;
    vector<int>sequence = {88,88+70};
    cout << "Found Sequence: ";
    auto found = search(scores.begin(),scores.end(),sequence.begin(),sequence.end());
    if(found!=scores.end()){
        cout << "Found";
    }
    else cout << "Not Found";
    cout << endl;
    cout << "Copying vectors" << endl;
    vector<int>copyVector = scores;
    for(auto it: copyVector){
        cout << it << ' ';
    }
    cout << endl;
    cout << "Swapping" << endl;
    swap(scores.front(),scores.back());
    for(auto it: scores){
        cout << it << ' ';
    }
    cout << endl;
    cout << "Sorting" << endl;
    sort(scores.begin(),scores.end());
    for(auto it: scores){
        cout << it << ' ';
    }
    cout << endl;

    vector<int>mergedVector(10);
    cout << "Merging" << endl;
    merge(scores.begin(),scores.end(),scores2.begin(),scores2.end(),mergedVector.begin());
    for(auto it: mergedVector){
      cout << it << ' ';
    }
    cout << endl;
    vector<float>percentageScore(5);
    int sum = accumulate(scores.begin(),scores.end(),0);
    cout << "Average: " << (float)sum/(float)scores.size() << endl;
    cout << "Updating Score" << endl;
    for_each(scores.begin(),scores.end(),element);
    for(auto it: scores){
        cout << it << ' ';
    }
    cout << endl;
    cout << "Transforming" << endl;
    transform(scores.begin(),scores.end(),percentageScore.begin(),percentage);
    for(auto it: percentageScore){
        cout << it << ' ';
    }

}
int element(int val){
    return val+=(val)/10;
}
