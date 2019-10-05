cmake_minimum_required(VERSION 3.0)


project(OpenFX)

find_package(Boost COMPONENTS filesystem system)

add_subdirectory("HostSupport")
add_subdirectory("Support")
add_subdirectory("Examples")



