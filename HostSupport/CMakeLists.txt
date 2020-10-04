cmake_minimum_required(VERSION 3.10)
project(HostSupport CXX)

find_package(Boost COMPONENTS system filesystem)
find_path(BOOST_DLL_INCLUDE_DIRS "boost/dll.hpp")


set(HostSupportSource src/ofxhBinary.cpp  src/ofxhHost.cpp  src/ofxhImageEffect.cpp
                      src/ofxhMemory.cpp  src/ofxhPluginAPICache.cpp  src/ofxhPropertySuite.cpp
                      src/ofxhClip.cpp    src/ofxhImageEffectAPI.cpp  src/ofxhInteract.cpp
                      src/ofxhParam.cpp   src/ofxhPluginCache.cpp     src/ofxhUtilities.cpp
                      )
                      
add_library(ofxHost ${HostSupportSource})
target_include_directories(ofxHost PUBLIC include ../include)
target_include_directories(ofxHost PUBLIC ${BOOST_DLL_INCLUDE_DIRS})
target_link_libraries(ofxHost PUBLIC Boost::filesystem)
target_link_libraries(ofxHost PUBLIC EXPAT::EXPAT)

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    target_link_libraries(ofxHost PUBLIC dl)
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
   target_compile_definitions(ofxHost PUBLIC WINDOWS)
endif()

if(Boost_FOUND)
    add_executable(PluginChecker BoostHost/main.cpp)
    target_link_libraries(PluginChecker Boost::filesystem ofxHost)
    target_include_directories(PluginChecker PUBLIC include ../include)
endif()


add_executable(ofxHostSimple examples/hostDemo.cpp                examples/hostDemoClipInstance.cpp
                             examples/hostDemoHostDescriptor.cpp  examples/hostDemoEffectInstance.cpp
                             examples/hostDemoParamInstance.cpp )
target_link_libraries(ofxHostSimple ofxHost)

