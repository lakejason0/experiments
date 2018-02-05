#include <iostream>
using namespace std;
int main()
{
    int P,Q;
    cin >> P;
    cin >> Q;
    swap(P,Q);
    cout << "P=" << P << "\n" << "Q=" << Q << "\n";
    return 0;
}
int swap(int &A, int &B)
{
    int TEMP;
    TEMP = A;
    A = B;
    B = TEMP;
    return 0;
}