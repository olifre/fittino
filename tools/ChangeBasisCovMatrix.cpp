//This program reads a matrix of integers 3x3 allocated within an ASCII file and shows the content on the screen

#include <stdio.h>
#include <iostream>

using std::cout;
using std::endl;
using namespace std;


main()
{
	FILE *fpt;
	float CovMatrixX[3][3];
    float CovMatrixA[3][3];
	int a, i, j, k, l;

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			CovMatrixX[i][j] = 0.0;
			CovMatrixA[i][j] = 0.0;

	fpt = fopen("CovMatrix.txt","r");
	if(fpt == NULL)
	{
		printf("\nError: File couldn't be opened (1).\n");
	}

	for(j = 0; j < 3; j++)
		for(i = 0; i < 3; i++)
			fscanf(fpt, "%f",&CovMatrixX[j][i]);
	fclose(fpt);

	//Printing out values to check
    cout << "The covariance matrix in the basis X is:" << endl;
    cout << "\n";

	for(i = 0; i < 3; i++)
	{
		for(j = 0; j < 3; j++)
		{
			printf("%f",CovMatrixX[i][j]);
			printf(" ");
		}
		putchar('\n');
	}

	//Calculating the covariance matrix in ther new basis
    cout << "\n";
    cout << "The covariance matrix in the basis A is:" << endl;
    cout << "\n";

    float Derivatives[3][3]; //The change of basis matrix

    for (i = 0; i < 3; i++)
    {
        for (j = 0; j < 3; j++)
		{
		    if (i=j)
		    {
		        Derivatives[i][j] = 1;
		    }
		    else
		    {
		        Derivatives[i][j] = 0;
		    }
        }
    }


	for(k = 0; k < 3; k++)
	{
		for(l = 0; l < 3; l++)
		{
		    for (i = 0; i < 3; i++)
		    {
		        for (j = 0; j < 3; j++)
		        {
		            CovMatrixA[k][l] = CovMatrixA[k][l] + Derivatives[k][i]*Derivatives[l][j]*CovMatrixX[i][j];
		        }
		    }
			printf("%f",CovMatrixA[k][l]);
			printf(" ");
		}
        putchar('\n');
	}



	return 0;
}
