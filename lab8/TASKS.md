===== Exercitii =====

**Task 1**  - Rulați task1 ca exemplu pentru debug (vedeți text laborator)

**Task 2**  - Deschideți fișierul task2.cu și urmăriți instrucțiunile pentru a măsura performanța maximă a unitații GPU, înregistrând numărul de GFLOPS
    * Masurati timpul petrecut in kernel Hint: Folositi evenimente CUDA.
    * Realizati profiling pentru functiile implementate folosind utilitarul nvprof.


**Task 3**  - Urmăriți TODO-uri din cadrul fișierului task3.cu
    * Completati functia matrix_multiply_simple care va realiza inmultirea a 2 matrice primite ca parametru.
    * Completati functia matrix_multiply care va realiza o inmultire optimizata a 2 matrice, folosind Blocked Matrix Multiplication. Hint: Se va folosi directiva __shared__ pentru a aloca memorie partajata intre thread-uri. Pentru sincronizarea thread-urilor se foloseste functia __syncthreads.
    * Masurati timpul petrecut in kernel Hint: Folositi evenimente CUDA.
    * Realizati profiling pentru functiile implementate folosind utilitarul nvprof.

