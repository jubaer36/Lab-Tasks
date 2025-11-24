#include<bits/stdc++.h>

using namespace std;

#define ll long long

vector<pair<ll,ll>>g[N];

void djk(ll node){
    vector<ll>vis(N,0);
    vector<ll>dis(N,LONG_MAX);
    multiset<pair<ll,ll>>st;
    st.insert({0,node});
    dis[node]=0;
    while(st.size()>0){
        auto source = *st.begin();
        ll v = source.second;
        ll dist= source.first;
        if(vis[v])continue;
        vis[v]=1;
        for(auto child:g[v]){

            

        }
        

    }



}
int main(){
    ll m,n;
    cin>>m>>n;


}
