COMPILER=nvcc
LIBS=-lm

%: %.cu
	$(COMPILER) -arch=sm_35 -rdc=true $^ -o $@ $(LIBS)

clean:
	rm -rf task5
