COMPILER=nvcc
LIBS=-lm

%: %.cu
	$(COMPILER) $^ -o $@ $(LIBS)

clean:
	rm -rf task21
	rm -rf task22
