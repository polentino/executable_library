#ifdef ELF_INTERPRETER_PATH

#include <stdio.h>
#include <stdlib.h>

//define the elf interpreter
extern const char elf_interpreter[] __attribute__((section(".interp"))) = ELF_INTERPRETER_PATH;

extern "C" void my_dump_function() {
    printf("Hello from custom entry point lib!\n"
           "\n"
           "Linker options provided: %s\n"
           "Compiled from branch %s, commit revision %s\n",
           CMAKE_CXX_FLAGS_STRING,
           CURRENT_GIT_BRANCH,
           CURRENT_GIT_COMMIT);
    exit(0);
}

#endif // ELF_INTERPRETER

