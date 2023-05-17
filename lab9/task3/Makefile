COMPILER=nvcc
LIBS=-lm

%: %.cu
	$(COMPILER) $^ -o $@ $(LIBS)

clean:
	rm -rf task31
	rm -rf task32
	rm -rf task33
