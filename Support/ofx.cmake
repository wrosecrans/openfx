

function(ofxPlugin name dir sources)
    message("Adding plugin '${name}' with ")
    add_library(${name} SHARED)
    foreach(src ${sources})
        message("  ${dir}/${src}")
        target_sources(${name} PRIVATE ${dir}/${src})
    endforeach()


    target_link_libraries(${name} OfxSupport)
endfunction()
