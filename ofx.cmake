
# See https://openfx.readthedocs.io/en/doc/Reference/ofxPackaging.html
#  for notes on the intended final directory structure.


# Support for Irix and 32 bit seems unnecessary at this point.
# The OFX spec does not specify bundle dir names for things like iOS or Android,
# and I have no experience with those platforms, so this is hopefully sufficient.

set(OFX_ARCHITECTURE "Unknown")
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   set(OFX_ARCHITECTURE "MacOS")
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
   set(OFX_ARCHITECTURE "Linux-x86-64")
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
   set(OFX_ARCHITECTURE "Win64")
endif()


function(setup_ofx_plugin name)
    set_target_properties(${name} PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Contents/${OFX_ARCHITECTURE}/
        RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Contents/${OFX_ARCHITECTURE}/)
    set_target_properties(${name} PROPERTIES PREFIX "")
    set_target_properties(${name} PROPERTIES SUFFIX ".ofx")
    if(${OFX_Tests})
        message("    Adding test ${name}_test ")
        add_test(NAME "${name}_test" COMMAND $<TARGET_FILE:PluginChecker> $<TARGET_FILE:${name}>)
    endif()

endfunction()

function(copy_ofx_resources name sources)
    foreach(src ${sources})
        if(${src} MATCHES ".*Info.plist")
            # message("  Found plist ${dir}/${src}")
            file(COPY "${dir}/${src}" DESTINATION "${PROJECT_BINARY_DIR}/${name}.ofx.bundle/")
        elseif(${src} MATCHES ".*\(\.svg|\.png|\.xml)")
            # message("  Found resource ${dir}/${src}")
            file(COPY "${dir}/${src}" DESTINATION "${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Resources/")
        elseif(${src} MATCHES ".*\(\.cc|\.[hH]|\.cpp)")
            # message("  Skipping source file from resource copying. ${src}")
        else()
            message("  Unknown resource: ${dir}/${src}")
            file(COPY "${dir}/${src}" DESTINATION "${PROJECT_BINARY_DIR}/${name}.ofx.bundle/Resources/")
        endif()
    endforeach()
endfunction()


function(add_ofx_plugin name sources)
    message("  Adding OFX plugin without Support library ${name}")
    add_library(${name} SHARED ${sources})
    copy_ofx_resources(${name} "${sources}")
    setup_ofx_plugin(${name})
    target_include_directories(${name} PUBLIC ../include/ )
endfunction()

function(add_ofxsupport_plugin name sources)
    message("  Adding OFX plugin using Support library ${name}")
    # message("${sources}")
    add_library(${name} SHARED ${sources})
    copy_ofx_resources(${name} "${sources}")
    setup_ofx_plugin(${name})
    target_link_libraries(${name} OfxSupport)
endfunction()


function(add_ofxsupport_example directory)
    # message("Adding OFX Support Example in ${directory}")
    file( GLOB example_sources
        Plugins/${directory}/*.cpp Plugins/${directory}/*.cc
        Plugins/${directory}/*.H Plugins/${directory}/*.h
        Plugins/${directory}/*.c
        Plugins/${directory}/*.plist
        Plugins/${directory}/*.svg
        Plugins/${directory}/*.png
        Plugins/${directory}/*.xml)
    add_ofxsupport_plugin(S_${directory} "${example_sources}")

endfunction()

function(add_ofx_example directory)
    file( GLOB example_sources
        ${directory}/*.cpp Plugins/${directory}/*.cc
        ${directory}/*.H Plugins/${directory}/*.h
        ${directory}/*.c
        ${directory}/*.plist
        ${directory}/*.svg
        ${directory}/*.png
        ${directory}/*.xml)
    add_ofx_plugin(${directory} "${example_sources}")
endfunction()


