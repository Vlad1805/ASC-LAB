COMPILER=nvcc
LIBS=-lm

all: taks2

%: %.cu
	$(COMPILER) $^ -o $@ $(LIBS)

clean:
	rm -rf task2
