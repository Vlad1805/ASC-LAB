#include <stdio.h>
#include <stdlib.h>
#include "utils.h"

#define NMAX		(1 << 20)

/**
 * ~TODO 3~
 * Modify the kernel below such as each element of the 
 * array will be now equal to 0 if it is an even number
 * or 1, if it is an odd number
 */
__global__ void kernel_parity_id(int *a, int N) {
    unsigned int i = threadIdx.x + blockDim.x * blockIdx.x;

	if (i < N)
	{
		a[i] %= 2;
	}
}

/**
 * ~TODO 4~
 * Modify the kernel below such as each element will
 * be equal to the BLOCK ID this computation takes
 * place.
 */
__global__ void kernel_block_id(int *a, int N) {
    unsigned int i = threadIdx.x + blockDim.x * blockIdx.x;

	if (i < N)
	{
		a[i] = blockIdx.x;
	}
}

/**
 * ~TODO 5~
 * Modify the kernel below such as each element will
 * be equal to the THREAD ID this computation takes
 * place.
 */ 
__global__ void kernel_thread_id(int *a, int N) {
    unsigned int i = threadIdx.x + blockDim.x * blockIdx.x;

	if (i < N)
	{
		a[i] = threadIdx.x;
	}
}

int main(void) {
    int nDevices;
	cudaDeviceProp prop;
	cudaError_t err;
	int i;
	int* host_a;
	int* device_a;

    // Get the number of CUDA-capable GPU(s)
    cudaGetDeviceCount(&nDevices);

    /**
     * ~TODO 1~
     * For each device, show some details in the format below, 
     * then set as active device the first one (assuming there
     * is at least CUDA-capable device). Pay attention to the
     * type of the fields in the cudaDeviceProp structure.
     *
     * Device number: <i>
     *      Device name: <name>
     *      Total memory: <mem>
     *      Memory Clock Rate (KHz): <mcr>
     *      Memory Bus Width (bits): <mbw>
     * 
     * Hint: look for cudaGetDeviceProperties and cudaSetDevice in
     * the Cuda Toolkit Documentation. 
     */
	for (i = 0; i < nDevices; ++i) {
		cudaGetDeviceProperties(&prop, i);

		printf("Device number: %d\n", i);
		printf("\tDevice name: %s\n", prop.name);
		printf("\tTotal memory: %zu\n", prop.totalGlobalMem);
		printf("\tMemory Clock Rate (KHz): %d\n", prop.memoryClockRate);
		printf("\tMemory Bus Width (bits): %d\n", prop.memoryBusWidth);
	}


    /**
     * ~TODO 2~
     * With information from example_2.cu, allocate an array with
     * integers (where a[i] = i). Then, modify the three kernels
     * above and execute them using 4 blocks, each with 4 threads.
     *
     * You can use the fill_array(int *a, int n) function (from utils)
     * to fill your array as many times you want.
     * 
     *  ~TODO 3~
     * Execute kernel_parity_id kernel and then copy from
     * the device to the host; call cudaDeviceSynchronize()
     * after a kernel execution for safety purposes.
     */ 

    host_a = (int*)malloc(NMAX * sizeof(int *));
    if (!host_a) {
        perror("malloc host_a");
        exit(1);
    }

	err = cudaMalloc(&device_a, NMAX * sizeof(*device_a));
    if (err != cudaSuccess) {
        perror("cudaMalloc device_a");
        exit(1);
    }

	fill_array_int(host_a, NMAX);

	err = cudaMemcpy(device_a, host_a, NMAX * sizeof(*host_a),
		cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        perror("cudaMemcpy host_a -> device_a");
        exit(1);
    }

    kernel_parity_id<<<NMAX / 4, 4>>>(device_a, NMAX);

	err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        perror("cudaDeviceSynchronize");
        exit(1);
    }

	err = cudaMemcpy(host_a, device_a, NMAX * sizeof(*host_a),
		cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) {
        perror("cudaMemcpy device_a -> host_a");
        exit(1);
    }

    // Uncomment the line below to check your results
    check_task_2(3, host_a);

    /**
     * ~TODO 4~
     * Execute kernel_block_id kernel and then copy from 
     * the device to the host;
     */

    kernel_block_id<<<NMAX / 4, 4>>>(device_a, NMAX);

	err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        perror("cudaDeviceSynchronize");
        exit(1);
    }

	err = cudaMemcpy(host_a, device_a, NMAX * sizeof(*host_a),
		cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) {
        perror("cudaMemcpy device_a -> host_a");
        exit(1);
    }

    // Uncomment the line below to check your results
    check_task_2(4, host_a);

    /**
     * ~TODO 5~
     * Execute kernel_thread_id kernel and then copy from 
     * the device to the host;
     */

    // Uncomment the line below to check your results

    // TODO 6: Free the memory
    kernel_thread_id<<<NMAX / 4, 4>>>(device_a, NMAX);

	err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        perror("cudaDeviceSynchronize");
        exit(1);
    }

	err = cudaMemcpy(host_a, device_a, NMAX * sizeof(*host_a),
		cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) {
        perror("cudaMemcpy device_a -> host_a");
        exit(1);
    }

    check_task_2(5, host_a);
	// TODO 6: Free the memory
	free(host_a);
	err = cudaFree(device_a);
    if (err != cudaSuccess) {
        perror("cudaFree device_a");
        exit(1);
    }
    
    return 0;
}