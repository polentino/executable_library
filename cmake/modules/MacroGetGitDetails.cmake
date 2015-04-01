# macro_get_git_details()
#
# This macro will extract useful informations from the repository where the
# sourcecode lives, adding some useful definitions.
# Once done, this will define:
#
#    CURRENT_GIT_BRANCH - the current branch you are in, or "none" if the source
#                         is not version controlled
#    CURRENT_GIT_COMMIT - the current commit hash, or "none" if the source
#                         is not version controlled
#
# Copyright (c) 2013, Diego [Po]lentino Casella, <polentino911 at gmail dot com>
# Redistribution and use is allowed according to the terms of the BSD license.

macro(macro_get_git_details)
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE return_value
        OUTPUT_VARIABLE _CURRENT_GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(NOT return_value)
        add_definitions(-DCURRENT_GIT_BRANCH="${_CURRENT_GIT_BRANCH}")
    elseif(NOT return_value)
        add_definitions(-DCURRENT_GIT_BRANCH="none")
    endif(NOT return_value)

    execute_process(
        COMMAND git rev-parse HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE return_value
        OUTPUT_VARIABLE _CURRENT_GIT_COMMIT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(NOT return_value)
        add_definitions(-DCURRENT_GIT_COMMIT="${_CURRENT_GIT_COMMIT}")
    elseif(NOT return_value)
        add_definitions(-DCURRENT_GIT_COMMIT="none")
    endif(NOT return_value)

endmacro(macro_get_git_details)
