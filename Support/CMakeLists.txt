cmake_minimum_required(VERSION 3.0)


project(Support)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
include(ofx.cmake)

set(SupportSource Library/ofxsCore.cpp  Library/ofxsInteract.cpp  Library/ofxsMultiThread.cpp
                  Library/ofxsProperty.cpp  Library/ofxsImageEffect.cpp  Library/ofxsLog.cpp
                  Library/ofxsParams.cpp  Library/ofxsPropertyValidation.cpp
                  )

add_library(OfxSupport ${SupportSource})

target_include_directories(OfxSupport PUBLIC include ../include)
set_property(TARGET OfxSupport PROPERTY POSITION_INDEPENDENT_CODE ON)


ofxPlugin(basic Plugins/Basic basic.cpp)
ofxPlugin(field Plugins/Field field.cpp)
set(Generator_Src randomGenerator.cpp noise.cpp)
ofxPlugin(generator Plugins/Generator "${Generator_Src}")
ofxPlugin(invert Plugins/Invert invert.cpp)
set(MB_Src PluginRegistration.cpp multibundle1.cpp)
ofxPlugin(multibundle Plugins/MultiBundle "${MB_Src}")
ofxPlugin(retimer Plugins/Retimer retimer.cpp)
ofxPlugin(tester Plugins/Tester Tester.cpp)
ofxPlugin(transition Plugins/Transition crossFade.cpp)

