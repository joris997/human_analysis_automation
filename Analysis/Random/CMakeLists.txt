add_executable(random
        main.cpp
        )

target_link_libraries(random common_options_target)
set_target_properties(random PROPERTIES FOLDER "Examples")
