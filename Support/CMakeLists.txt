cmake_minimum_required(VERSION 3.0)


project(Support)


set(SupportSource Library/ofxsCore.cpp  Library/ofxsInteract.cpp  Library/ofxsMultiThread.cpp
                  Library/ofxsProperty.cpp  Library/ofxsImageEffect.cpp  Library/ofxsLog.cpp
                  Library/ofxsParams.cpp  Library/ofxsPropertyValidation.cpp
                  )

add_library(OfxSupport ${SupportSource})

target_include_directories(OfxSupport PUBLIC include ../include)
