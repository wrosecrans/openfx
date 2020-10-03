cmake_minimum_required(VERSION 3.0)


project(Support)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
include(ofx.cmake)
find_path(BOOST_DLL_INCLUDE_DIRS "boost/dll.hpp")

set(SupportSource Library/ofxsCore.cpp  Library/ofxsInteract.cpp  Library/ofxsMultiThread.cpp
                  Library/ofxsProperty.cpp  Library/ofxsImageEffect.cpp  Library/ofxsLog.cpp
                  Library/ofxsParams.cpp  Library/ofxsPropertyValidation.cpp
                  )

add_library(OfxSupport ${SupportSource})

target_compile_definitions(OfxSupport PUBLIC NOMINMAX)


target_include_directories(OfxSupport PUBLIC include ../include)
target_include_directories(OfxSupport PRIVATE ${BOOST_DLL_INCLUDE_DIRS})
set_property(TARGET OfxSupport PROPERTY POSITION_INDEPENDENT_CODE ON)



ofxPlugin(field Plugins/Field "field.cpp;info.plist")

set(Generator_Src randomGenerator.cpp noise.cpp info.plist)
ofxPlugin(generator Plugins/Generator "${Generator_Src}")

ofxPlugin(invert Plugins/Invert "invert.cpp;info.plist")

ofxPlugin(retimer Plugins/Retimer "retimer.cpp;info.plist")

ofxPlugin(transition Plugins/Transition "crossFade.cpp;info.plist")


if(OPENGL_FOUND)
    ofxPlugin(basic Plugins/Basic basic.cpp)
    target_link_libraries(basic OpenGL::GL)

    set(MB_Src PluginRegistration.cpp multibundle1.cpp multibundle2.cpp)
    ofxPlugin(multibundle Plugins/MultiBundle "${MB_Src}")
    target_link_libraries(multibundle OpenGL::GL)

    ofxPlugin(tester Plugins/Tester Tester.cpp)
    target_link_libraries(tester OpenGL::GL)

endif()
