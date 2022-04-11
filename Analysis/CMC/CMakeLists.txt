add_executable(cmc
        main.cpp
        )

target_link_libraries(cmc common_options_target)
set_target_properties(cmc PROPERTIES FOLDER "Examples")
