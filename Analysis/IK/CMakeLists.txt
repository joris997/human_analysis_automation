add_executable(ik
        main.cpp
        )

target_link_libraries(ik common_options_target)
set_target_properties(ik PROPERTIES FOLDER "Examples")
