add_executable(tocode
        main.cpp
        )

target_link_libraries(tocode common_options_target)
set_target_properties(tocode PROPERTIES FOLDER "Examples")
