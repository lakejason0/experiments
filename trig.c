#include <stdio.h>
#include <math.h>
// 程序框图出自人教A版必修四P136
int main()
{
	float s0,c0,s,c;
	int n;
	printf("Input the approx. value of sin 1\'\n? ");
	scanf("%f",&s0);
	c0=sqrt(1-s0*s0);
	printf("%f",s0);
	s=s0;
	c=c0;
	n=2;
	do{
		s=s*c0+c*s0;
		c=sqrt(1-s*s);
		printf("%.8f\n",s);
		n++;
	}while(!(n>5400));
	return 0;
}