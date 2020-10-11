cmake_minimum_required(VERSION 3.10)


project(Examples)
add_custom_target(data COMMAND dir SOURCES README.txt XML/example.xml)


foreach(example Basic Custom DepthConverter Invert OpenGL Overlay Rectangle Test)
    add_ofx_example(${example})
endforeach()

