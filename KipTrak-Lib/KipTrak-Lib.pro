include(../qmake-target-platform.pri)
include(../qmake-destination-path.pri)

QT -= gui
QT += sql network

TEMPLATE = lib
DEFINES += KIPTRAKLIB_LIBRARY

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    assignment.cpp \
    datadecorator.cpp \
    datetimedecorator.cpp \
    downloader.cpp \
    entity.cpp \
    entitycollection.cpp \
    enumeratordecorator.cpp \
    fileupload.cpp \
    imageuploader.cpp \
    intdecorator.cpp \
    mastercontroller.cpp \
    networkaccessmanager.cpp \
    stringdecorator.cpp \
    webrequest.cpp

HEADERS += \
    KipTrak-Lib_global.h \
    assignment.h \
    datadecorator.h \
    datetimedecorator.h \
    downloader.h \
    entity.h \
    entitycollection.h \
    enumeratordecorator.h \
    fileupload.h \
    imageuploader.h \
    inetworkaccessmanager.h \
    intdecorator.h \
    iwebrequest.h \
    mastercontroller.h \
    navigationcontroller.h \
    networkaccessmanager.h \
    stringdecorator.h \
    webrequest.h

DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
# Default rules for deployment.
unix {
    target.path = /usr/lib
}
!isEmpty(target.path): INSTALLS += target
