add_executable(angularMomentum
        main.cpp
        )

target_link_libraries(angularMomentum common_options_target)
set_target_properties(angularMomentum PROPERTIES FOLDER "Examples")
