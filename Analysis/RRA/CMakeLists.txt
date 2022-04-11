add_executable(rra
        main.cpp
        )

target_link_libraries(rra common_options_target)
set_target_properties(rra PROPERTIES FOLDER "Examples")
