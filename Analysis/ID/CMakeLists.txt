add_executable(id
        main.cpp
        )

target_link_libraries(id common_options_target)
set_target_properties(id PROPERTIES FOLDER "Examples")
