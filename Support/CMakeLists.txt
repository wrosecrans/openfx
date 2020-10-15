cmake_minimum_required(VERSION 3.10)
project(Support)

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


# add_ofxsupport_example() prefixes the examples with "S_" to avoid target name collisions
# with the similar examples that don't use the C++ Support library.
if(OFX_Build_Examples)

    foreach(example Field Generator Invert Retimer Transition)
        add_ofxsupport_example(${example})
    endforeach()

    if(${OPENGL_FOUND})
        foreach(example Basic MultiBundle Tester)
            add_ofxsupport_example(${example})
            target_link_libraries(S_${example} OpenGL::GL)
        endforeach()
    endif(${OPENGL_FOUND})

endif(OFX_Build_Examples)

