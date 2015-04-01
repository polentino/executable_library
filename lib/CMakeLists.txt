find_package(ELFInterpreter)

set(LIB_SRC
    samplelib.cpp
    dump_function.cpp
)

if(ELF_INTERPRETER_FOUND)

    # if we found the interpreter, then we can add the dump function to the library
    set(LIB_SRC
        ${LIB_SRC}
        dump_function.cpp
    )

    # get more infos
    include(MacroGetGitDetails)
    macro_get_git_details()

    set(MYLIB_FLAGS "-e my_dump_function")
    set(CMAKE_CXX_FLAGS_DEBUG "-g -O2 -fno-reorder-blocks -fno-schedule-insns -fno-inline")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} ${MYLIB_FLAGS}")

endif(ELF_INTERPRETER_FOUND)

add_definitions(-DCMAKE_CXX_FLAGS_STRING="${CMAKE_CXX_FLAGS}")

add_library(SampleLib SHARED ${LIB_SRC})

