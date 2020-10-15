cmake_minimum_required(VERSION 3.10)


project(Examples)
add_custom_target(examples_data COMMAND dir SOURCES README.txt XML/example.xml)


foreach(example Basic DepthConverter Invert Rectangle Test)
    add_ofx_example(${example})
endforeach()

if(${OPENGL_FOUND})
    foreach(example Custom OpenGL Overlay)
        add_ofx_example(${example})
        target_link_libraries(${example} OpenGL::GL)
    endforeach()
endif()
