#include <stdio.h>

void displayResult(int, int);
void prepareData(int[], int[], int[]);
int processData(int[]);

#define SIZE 20
#define SIZE12 10

/*
  1. Do NOT declare ANY global variables
  2. ALL variables MUST be declared within the main function
  3. Declaring global constants using the #define keyword is okay
  4. Pass appropriate variables as arguments to each function
  5. The function MUST be an exact translation of the MIPS assembly code
*/
int main() {
	int array[SIZE] = {35,-34,82,-95,-2,22,-17,80,-67,-39,64,94,-96,95,-70,-63,69,-3,75,-10};
	int array1[SIZE12];
	int array2[SIZE12];
	
	prepareData(array, array1, array2);
	
	int result1 = processData(array1);
	int result2 = processData(array2);
	
	displayResult(result1, result2);

    return 0;
}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
void displayResult(int input1, int input2) {
    int sum = input1 + input2;
    
	printf("Assignment 3\n");
	printf("------------\n");
	printf("Result:   %d", sum);
	printf("\n");
}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
void prepareData(int srcArray[], int oddArray[], int evenArray[]) {
    int oddIndex = 0;
    int evenIndex = 0;
    
    for (int i = 0; i < SIZE; i++) {
        if (srcArray[i] % 2 == 0) {  
            evenArray[evenIndex] = srcArray[i];
            evenIndex++;
        }
        else {
            oddArray[oddIndex] = srcArray[i];
            oddIndex++;
        }
    }
}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
int processData(int input[]) {
    int i;
    int num = 100;
    
    for (i = 0; i < SIZE12; i++) {
        if (i % 2 == 0) {
            num += input[i];
        }
        else {
            num -= input[i];
        }
    }
    
	return num; // Return the appropriate value
}