#include <iostream> 
using namespace std; 
int swap(int &a, int &b){ //�β� 
    int temp; 
    temp=a;a=b;b=temp; 
    return a,b;
} 
int main(){ 
    int x,y; 
    cin >> x;
	cin >> y; 
    swap(x,y); //ʵ�� 
    cout<<"x:"<<x<<endl; 
    cout<<"y:"<<y<<endl; 
    return 0; 
} 

