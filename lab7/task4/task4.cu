#include <stdio.h>
#include <math.h>
#include "utils.h"

// TODO 6: Write the code to add the two arrays element by element and 
// store the result in another array
__global__ void add_arrays(const float *a, const float *b, float *c, int N) {
	unsigned int i = threadIdx.x + blockDim.x * blockIdx.x;

	if (i < N)
	{
		c[i] = a[i] + b[i];
	}
}

int main(void) {
    cudaSetDevice(0);
    int N = 1 << 20;

    float *host_array_a = NULL;
    float *host_array_b = NULL;
    float *host_array_c = NULL;

    float *device_array_a = NULL;
    float *device_array_b = NULL;
    float *device_array_c = NULL;

	cudaError_t err;

	const size_t block_size = 256;
	size_t num_blocks;

    // TODO 1: Allocate the host's arrays
    host_array_a = (float*)malloc(N * sizeof(*host_array_a));
	if (host_array_a == NULL){
		perror("malloc(host_array_a) failed\n");
		return 1;
	}

	host_array_b = (float*)malloc(N * sizeof(*host_array_b));
	if (host_array_b == NULL){
		perror("malloc(host_array_b) failed\n");
		return 1;
	}

	host_array_c = (float*)malloc(N * sizeof(*host_array_c));
	if (host_array_c == NULL){
		perror("malloc(host_array_c) failed\n");
		return 1;
	}
	
	// TODO 2: Allocate the device's arrays
    int err = cudaMalloc(&device_array_a, N * sizeof(*device_array_a));
	if (err != cudaSuccess || device_array_a == NULL)
	{
		perror("cudaMalloc(device_array_a) failed\n");
		return 1;
	}

	err = cudaMalloc(&device_array_b, N * sizeof(*device_array_b));
	if (err != cudaSuccess || device_array_b == NULL)
	{
		perror("cudaMalloc(device_array_b) failed\n");
		return 1;
	}

	err = cudaMalloc(&device_array_c, N * sizeof(*device_array_c));
	if (err != cudaSuccess || device_array_c == NULL)
	{
		perror("cudaMalloc(device_array_c) failed\n");
		return 1;
	}

    // TODO 3: Check for allocation errors


    // TODO 4: Fill array with values; use fill_array_float to fill
    // host_array_a and fill_array_random to fill host_array_b. Each
    // function has the signature (float *a, int n), where n = the size.
	fill_array_float(host_array_a, N);
	fill_array_random(host_array_b, N);
    
    // TODO 5: Copy the host's arrays to device
    err = cudaMemcpy(device_array_a, host_array_a, N * sizeof(*host_array_a), cudaMemcpyHostToDevice);
	if (err != cudaSuccess)
	{
		perror("cudaMemcpy(host_array_a) failed\n");
		return 1;
	}

	err = cudaMemcpy(device_array_b, host_array_b, N * sizeof(*host_array_b), cudaMemcpyHostToDevice);
	if (err != cudaSuccess)
	{
		perror("cudaMemcpy(host_array_b) failed\n");
		return 1;
	}


    // TODO 6: Execute the kernel, calculating first the grid size
    // and the amount of threads in each block from the grid
	num_blocks = N / block_size;

	if (N % block_size)
	{
		++num_blocks;
	}

	add_arrays<<<num_blocks, block_size>>>(device_array_a, device_array_b, device_array_c, N);

	err = cudaDeviceSynchronize();
	if (err != cudaSuccess)
	{
		perror("cudaDeviceSynchronize failed\n");
		return 1;
	}

    // TODO 7: Copy back the results and then uncomment the checking function
	err = cudaMemcpy(host_array_c, device_array_c,
		N * sizeof(*host_array_c), cudaMemcpyDeviceToHost);
	if (err != cudaSuccess)
		{
			perror("cudaMemcpy(host_array_c) failed\n");
			return 1;
		}

    check_task_3(host_array_a, host_array_b, host_array_c, N);

    // TODO 8: Free the memory
	free(host_array_a);
	free(host_array_b);
	free(host_array_c);

	err = cudaFree(device_array_a);
	if (err != cudaSuccess)
	{
		perror("cudaFree(device_array_a) failed\n");
		return 1;
	}

	err = cudaFree(device_array_b);
	if (err != cudaSuccess)
	{
		perror("cudaFree(device_array_b) failed\n");
		return 1;
	}

	err = cudaFree(device_array_c);
	if (err != cudaSuccess)
	{
		perror("cudaFree(device_array_c) failed\n");
		return 1;
	}

    return 0;
}