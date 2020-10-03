cmake_minimum_required(VERSION 3.14)


project(OpenFX)


find_package(OpenGL)
find_package(EXPAT REQUIRED)
find_package(Boost COMPONENTS filesystem system)
find_path(BOOST_DLL_INCLUDE_DIRS "boost/dll.hpp")


# If you are using this project as a submodule of some other plugin's repo,
# you can set only OFX_Build_Support before you add_subdirectort() this file.
# if you want to skip building sample plugins and whatnot.

Option(OFX_Build_Host "Build the OpenFX HostSupport library and examples" ON)
Option(OFX_Build_Support "Build the OpenFX Plugin Support library (and examples if examples is on)" ON)
Option(OFX_Build_Examples "Build the OpenFX Example plugins" ON)
Option(OFX_Verbose "Print some optional messages" ON)

if(OFX_Build_Host)
    add_subdirectory("HostSupport")
endif()

if(OFX_Build_Support)
    add_subdirectory("Support")
endif()

if(OFX_Build_Examples)
    add_subdirectory("Examples")
endif()



