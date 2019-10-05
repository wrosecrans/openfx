cmake_minimum_required(VERSION 3.0)


project(HostSupport)

set(HostSupportSource src/ofxhBinary.cpp  src/ofxhHost.cpp  src/ofxhImageEffect.cpp
                      src/ofxhMemory.cpp  src/ofxhPluginAPICache.cpp  src/ofxhPropertySuite.cpp
                      src/ofxhClip.cpp    src/ofxhImageEffectAPI.cpp  src/ofxhInteract.cpp
                      src/ofxhParam.cpp   src/ofxhPluginCache.cpp     src/ofxhUtilities.cpp
                      )
                      
add_library(ofxHost ${HostSupportSource})


target_include_directories(ofxHost PUBLIC include ../include)

find_package(Boost COMPONENTS system filesystem)

if(Boost_FOUND)
    add_executable(PluginChecker BoostHost/main.cpp)
    target_link_libraries(PluginChecker Boost::filesystem dl)
    target_include_directories(PluginChecker PUBLIC include ../include)
endif()


add_executable(ofxHostSimple examples/hostDemo.cpp)
target_link_libraries(ofxHostSimple ofxHost)

