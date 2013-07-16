#-------------------------------------------------
#
# Project created by QtCreator 2013-06-01T13:09:05
#
#-------------------------------------------------
INCLUDEPATH += /usr/include
LIBS += -L/usr/lib -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab
QT       += core

QT       -= gui

TARGET = 130601qgpu

TEMPLATE = app


SOURCES += main.cpp \
    kaze_config.cpp \
    kaze_utils.cpp \
    kaze_nldiffusion_functions.cpp \
    kaze_ipoint.cpp \
    kaze_features.cpp \
    kaze.cpp

HEADERS += \
    kaze_config.h \
    kaze_utils.h \
    kaze_nldiffusion_functions.h \
    kaze_ipoint.h \
    kaze_features.h \
    kaze.h

OTHER_FILES += \
    130601qgpu.pro.user
