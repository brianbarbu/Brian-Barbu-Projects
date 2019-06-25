//Brian Baru

#include <iostream>
using namespace std;

int xToN(int x, int n)
{
    if (n == 0)
    {
        return 1;
    }
    return x * xToN(x, n - 1);
}

int main()
{
    int x;
    int n;
    cout << "What is the base number (x) ?";
    cin >> x;
    cout << "What is the exponent (n) ?";
    cin >> n;
    cout << xToN(x, n); 
}
