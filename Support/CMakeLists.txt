cmake_minimum_required(VERSION 3.10)
project(Support)

#set(CMAKE_POSITION_INDEPENDENT_CODE ON)
#find_path(BOOST_DLL_INCLUDE_DIRS "boost/dll.hpp")

include(ofx.cmake)

set(SupportSource Library/ofxsCore.cpp  Library/ofxsInteract.cpp  Library/ofxsMultiThread.cpp
                  Library/ofxsProperty.cpp  Library/ofxsImageEffect.cpp  Library/ofxsLog.cpp
                  Library/ofxsParams.cpp  Library/ofxsPropertyValidation.cpp
                  )

add_library(OfxSupport ${SupportSource})

target_include_directories(OfxSupport PUBLIC include ../include)
target_include_directories(OfxSupport PRIVATE ${BOOST_DLL_INCLUDE_DIRS})
set_property(TARGET OfxSupport PROPERTY POSITION_INDEPENDENT_CODE ON)

# Very helpful on Windows.  Should be harmless on other platforms, and keeps builds consistent.
target_compile_definitions(OfxSupport PUBLIC NOMINMAX)


if(OFX_Build_Examples)

    ofxPlugin(field Plugins/Field "field.cpp;Info.plist")

    set(Generator_Src randomGenerator.cpp noise.cpp Info.plist)
    ofxPlugin(generator Plugins/Generator "${Generator_Src}")

    ofxPlugin(invert Plugins/Invert "invert.cpp;Info.plist")

    ofxPlugin(retimer Plugins/Retimer "retimer.cpp;Info.plist")

    ofxPlugin(transition Plugins/Transition "crossFade.cpp;Info.plist")


    if(OPENGL_FOUND)
        ofxPlugin(basic Plugins/Basic "basic.cpp;Info.plist")
        target_link_libraries(basic OpenGL::GL)

        set(MB_Src PluginRegistration.cpp multibundle1.cpp multibundle2.cpp Info.plist)
        ofxPlugin(multibundle Plugins/MultiBundle "${MB_Src}")
        target_link_libraries(multibundle OpenGL::GL)

        ofxPlugin(tester Plugins/Tester Tester.cpp Info.plist)
        target_link_libraries(tester OpenGL::GL)

    endif(OPENGL_FOUND)

endif(OFX_Build_Examples)
