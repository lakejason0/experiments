//���ߣ�yan li
//���ӣ�https://www.zhihu.com/question/30782166/answer/100475928
//��Դ��֪��
//����Ȩ���������С���ҵת������ϵ���߻����Ȩ������ҵת����ע��������

#include <stdio.h>
#include <tchar.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
using namespace std;

#define SIZE 40 //���������С
//#define NUMLIFE 3
//#define NUMNOCHANGE 2
#define ALIVE 1
#define DEAD 0

int state(int* a, int i, int j, int numLife, int numNoChange)
{
	int sum=*(a+(i-1)*SIZE+(j-1))+*(a+(i-1)*SIZE+(j))+*(a+(i-1)*SIZE+(j+1))
		+*(a+(i)*SIZE+(j-1))+*(a+(i)*SIZE+(j+1))
		+*(a+(i+1)*SIZE+(j-1))+*(a+(i+1)*SIZE+(j))+*(a+(i+1)*SIZE+(j+1));
	if(sum==numLife)
		return ALIVE;
	else if(sum==numNoChange)
		return *(a+(i)*SIZE+(j));
	else
		return DEAD;
}

int main(int argc, char* argv[])
{
	//����ʱ���������������ֱ�����ϸ������ھӸ���(eg. 3)�Լ���ϸ��״̬������ھӸ���(eg. 2)
	int NUMLIFE=atoi(argv[1]);
	int NUMNOCHANGE=atoi(argv[2]);

	int a[SIZE][SIZE];
	int b[SIZE][SIZE];
	srand(time(0)); //����Ҫ�����

	//������ó�ʼ״̬����������
	for(int i=0;i<SIZE;i++)
		for(int j=0;j<SIZE;j++)
			a[i][j]=0;

	for(int i=1;i<SIZE-1;i++)
		for(int j=1;j<SIZE-1;j++)
			a[i][j]=rand()%2;
	
	for(int i=0;i<SIZE;i++)
	{
		for(int j=0;j<SIZE;j++)
		{
			cout<<a[i][j]<<" ";
		}
		cout<<endl;
	}

	for(int i=1; i<=200; i++)
	{
		int count=0;

		for(int i=1;i<SIZE-1;i++)
			for(int j=1;j<SIZE-1;j++)
				b[i][j]=state(&a[0][0], i, j, NUMLIFE, NUMNOCHANGE);

		for(int i=1;i<SIZE-1;i++)
			for(int j=1;j<SIZE-1;j++)
			{
				a[i][j]=b[i][j];
				count+=a[i][j];
			}
		
		system("clear");
		cout<<"��"<<i<<"���󣬻���"<<count<<"��������"<<endl;
		
		for(int i=0;i<SIZE;i++)
		{
			for(int j=0;j<SIZE;j++)
			{
				if(a[i][j]==0)			
					cout<<"  ";
				else
					cout<<"o ";
			}
			cout<<endl;
		}
		cout<<endl;
		system("sleep 0.2");
		
	}

	system("pause");
	return 0;
}
