cmake_minimum_required(VERSION 3.0)


project(HostSupport)

set(HostSupportSource src/ofxhBinary.cpp  src/ofxhHost.cpp  src/ofxhImageEffect.cpp
                      src/ofxhMemory.cpp  src/ofxhPluginAPICache.cpp  src/ofxhPropertySuite.cpp
                      src/ofxhClip.cpp    src/ofxhImageEffectAPI.cpp  src/ofxhInteract.cpp
                      src/ofxhParam.cpp   src/ofxhPluginCache.cpp     src/ofxhUtilities.cpp
                      )
                      
add_library(ofxHost ${HostSupportSource})

target_include_directories(ofxHost PUBLIC include ../include expat-2.0.1/lib)
target_link_libraries(ofxHost Boost::filesystem)

add_executable(ofxHostSimple examples/hostDemo.cpp)
target_link_libraries(ofxHostSimple ofxHost)

