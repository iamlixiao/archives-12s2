#-------------------------------------------------
#
# Project created by QtCreator 2013-06-20T21:56:21
#
#-------------------------------------------------
INCLUDEPATH += /usr/include
LIBS += -L/usr/lib -lsndfile -lfftw3 -lm

QT       += core gui multimedia

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = 130620qsnd
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    gram2d.cpp \
    gram2du.cpp \
    gram2ds.cpp \
    gram2dru.cpp \
    gram2d5.cpp

HEADERS  += mainwindow.h \
    gram2d.h \
    gram2du.h \
    gram2ds.h \
    gram2dru.h \
    gram2d5.h

FORMS    += mainwindow.ui
