cmake_minimum_required(VERSION 3.10)


project(Examples)
add_custom_target(examples_data COMMAND dir SOURCES README.txt XML/example.xml)


foreach(example Basic Custom DepthConverter Invert Overlay Rectangle Test)
    add_ofx_example(${example})
endforeach()

if(${OPENGL_FOUND})
    foreach(example OpenGL)
        add_ofx_example(${example})
        target_link_libraries(${example} OpenGL::GL)
    endforeach()
endif()
