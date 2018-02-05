#include <string>
#include <iostream>
using  std::string;
using  std::wstring;
using  namespace std;
int nosense(int &a)
{
    cout << "a=" << a << "\n";
    return 0;
}
int _Str(string &b)
{
	cout << b << "\n";
	return 0;
}
int main()
{
    int p;
    string q;
    getline(cin,q);
    nosense(p);
    _Str(q);
	return 0;
} 


