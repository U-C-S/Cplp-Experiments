
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>


__global__ void addKernel(int* c, const int* a, const int* b)
{
		int i = threadIdx.x;
		c[i] = a[i] + b[i];
}

int main()
{
		const int arraySize = 5;
		const int a[arraySize] = { 1, 2, 3, 4, 5 };
		const int b[arraySize] = { 10, 20, 30, 40, 50 };
		int c[arraySize] = { 0 };
		int int_size = sizeof(int);

		int* d_a, d_b, d_result;

		cudaMalloc(&d_a, arraySize * int_size);
		cudaMalloc(&d_b, arraySize * int_size);
		cudaMalloc(&d_result, arraySize * int_size);


		// Add vectors in parallel.
		addKernel<<<1, arraySize >>>(c, a, b);

		printf("{1,2,3,4,5} + {10,20,30,40,50} = {%d,%d,%d,%d,%d}\n",
				c[0], c[1], c[2], c[3], c[4]);

		// cudaDeviceReset must be called before exiting in order for profiling and
		// tracing tools such as Nsight and Visual Profiler to show complete traces.
		cudaError_t cudaStatus = cudaDeviceReset();
		if (cudaStatus != cudaSuccess) {
				fprintf(stderr, "cudaDeviceReset failed!");
				return 1;
		}

		return 0;
}