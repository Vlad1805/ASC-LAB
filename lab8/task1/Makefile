COMPILER=nvcc
LIBS=-lm

all: task1

%: %.cu
	$(COMPILER) -g $^ -o $@ $(LIBS)

clean:
	rm -rf task1
