
# See https://openfx.readthedocs.io/en/doc/Reference/ofxPackaging.html
#  for notes on the intended final directory structure.


# Support for Irix and 32 bit seems unnecessary at this point.
# The OFX spec does not specify bundle dir names for things like iOS or Android,
# and I have no experience with those platforms, so this is hopefully sufficient.

set(OFX_ARCHITECTURE "Unknown")
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   SET(OFX_ARCHITECTURE "MacOS")
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
   SET(OFX_ARCHITECTURE "Linux-x86-64")
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
   SET(OFX_ARCHITECTURE "Win64")
endif()

function(ofxPlugin name dir sources)
    message("Project binary dir: ${PROJECT_BINARY_DIR} : ${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Contents/${OFX_ARCHITECTURE}/")
    message("Adding plugin '${name}' with ")
    add_library(${name} SHARED)
    foreach(src ${sources})

        if(${src} MATCHES "Info.plist")
            message("  Found plist ${dir}/${src}")
            file(COPY "${dir}/${src}" DESTINATION "${PROJECT_BINARY_DIR}/${name}.ofx.bundle/")

        elseif(${src} MATCHES ".*\(\.svg|\.png|\.xml)")
                message("  Found resource ${dir}/${src}")
                file(COPY "${dir}/${src}" DESTINATION "${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Resources/")
        else()
            message("  ${dir}/${src}")
        endif()
        target_sources(${name} PRIVATE ${dir}/${src})
    endforeach()


    target_link_libraries(${name} OfxSupport)
    set_target_properties(${name} PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Contents/${OFX_ARCHITECTURE}/
        RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Contents/${OFX_ARCHITECTURE}/)
    set_target_properties(${name} PROPERTIES PREFIX "")
    set_target_properties(${name} PROPERTIES SUFFIX ".ofx")
endfunction()
