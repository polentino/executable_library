# - Try to find an ELF object file interpreter
# Once done, this will define:
#
#    ELF_INTERPRETER_FOUND - the script successfully found an ELF interprete
#    ELF_INTERPRETER_PATH - the absolute path of the elf interpreter
#
# Note: if for some reason the INTERPRETER_DESCRIPTION does not match the one
#       listed here, you can always define your own _before_ calling this
#       function.
#
#
# Copyright (c) 2013, Diego [Po]lentino Casella, <polentino911 at gmail dot com>
# Redistribution and use is allowed according to the terms of the BSD license.

# if we already have found the elf interpreter, there's no need to exec this again
if(NOT ELF_INTERPRETER_FOUND)

    # if the user didn't provided a custom INTERPRETER_DESCRIPTION, then let's
    # use the standard one
    if(NOT INTERPRETER_DESCRIPTION)
        set(INTERPRETER_DESCRIPTION "Requesting program interpreter:")
    endif(NOT INTERPRETER_DESCRIPTION)

    # execute readelf -l /bin/ls
    execute_process(COMMAND readelf -l /bin/ls
        RESULT_VARIABLE return_value
        OUTPUT_VARIABLE result
    )

    # if the execution was successful, then retrieve the absolute path of the
    # interpreter and prompt its value: otherwise prompt a message.
    if(return_value)
        message(STATUS "Cannot find a valid ELF interpreter")

    else()
        string(REGEX REPLACE
            ".*[[]${INTERPRETER_DESCRIPTION} ([/][^ ].+)[]].*" "\\1"
            _ELF_INTERPRETER_PATH "${result}"
        )

        # add the definition
        add_definitions( -DELF_INTERPRETER_PATH="${_ELF_INTERPRETER_PATH}" )
        message(STATUS "Checking ELF interpreter - ${_ELF_INTERPRETER_PATH}")
        # set ELF_INTERPRETER_FOUND to TRUE
        set(ELF_INTERPRETER_FOUND TRUE)
    endif()

endif(NOT ELF_INTERPRETER_FOUND)

