# RISC-V Doubly-Linked List 

A RISC-V doubly-linked list. `nd24sp-arch-hw4-report.pdf` explains how step iterates on the problem and `dllist_final.S` contains the final product.

In summary, the final assembly file:
- allocates the necessary memory for several nodes of a dllist
- inputs data into that dllist
- selectively deletes a node from the dllist
- frees all data from memory

The project was tested using [Cornell's RISC-V Interpreter](https://www.cs.cornell.edu/courses/cs3410/2020sp/riscv/interpreter/), on which this code will run as described. There you can view all the registers and memory addresses as they update in real time.

The project received 1970/2000 possible points. The grading rubric can be found [here](https://1drv.ms/b/s!AqJFCYsmSa2bgrFGWqq6KhYCn6TiSg?e=5oet1s).

## Authors
- [Max Graves](https://github.com/gmax9803)
- [Aaron Lewis](https://github.com/aaron-m-lewis)
- [Sam Monterola](https://github.com/smonterola)
- [Charlie Gussen](https://github.com/cgussen)

## Relevent Files
- `dllist_step1.S`
- `dllist_step2.S`
- `dllist_step3.S`
- `dllist_step4.S`
- `dllist_final.S` 
- `nd24sp-arch-hw4-report.pdf`
