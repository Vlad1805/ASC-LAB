===== Exercitii =====

**Task 1**  - Rulați task1 ca exemplu pentru execuția de programe kernel din thread-urile ce ruleaza pe device/GPU, respectiv pentru operații atomice.

**Task 2**  - Deschideți fișierele task21.cu, task22.cu și completati cu alocarile/trasferurile de memorie cerute
    * task21.cu In functia compute_NoUnifiedMem se va aloca memorie cu cudaMalloc.
    * task22.cu In functia compute_UnifiedMem se va aloca memorie cu cudaMallocManaged.
    * Folosind nvprof analizati cum ruleaza cele 2 programe și completați fișierul discutie.txt cu observații:
      * ''nvprof ./task21''  (sau ''make -f Makefile_Cluster nvprof_run_task21'')
      * ''nvprof ./task22''  (sau ''make -f Makefile_Cluster nvprof_run_task22'')


**Task 3**  - Deschideți fișierele task31.cu, task32.cu, task33.cu si urmăriți instrucțiunile TODO
    * task31.cu completați funcția kernel_no_atomics
    * task32.cu completați funcția kernel_partial_atomics 
    * task33.cu completați funcția kernel_full_atomics
    * Folosind nvprof analizati cum ruleaza cele 3 programe și completați fișierul discutie.txt cu observații:
      * ''nvprof ./task31''  (sau ''make -f Makefile_Cluster nvprof_run_task31'')
      * ''nvprof ./task32''  (sau ''make -f Makefile_Cluster nvprof_run_task32'')
      * ''nvprof ./task33''  (sau ''make -f Makefile_Cluster nvprof_run_task33'')


**Task 4**  - Deschideti fisierul task4.cu si urmăriți instrucțiunile TODO
    * Se da un vector cu sloturi ocupate (.raw!=0) sau libere (.raw=0) si un set de elemente de inserat.

**Task 5**  - Deschideti fisierul task5.cu si urmăriți instrucțiunile TODO
    *  Folosind dynamic parallelism se va calcula suma primelor data[i] elemente din vectorul data[]
