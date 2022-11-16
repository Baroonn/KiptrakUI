include(../qmake-target-platform.pri)
include(../qmake-destination-path.pri)

QT += quick
QT += network

SOURCES += \
        main.cpp

resources.files = main.qml CreateAssignmentDTComponent.qml GetAssignmentPage.qml CreateFlickableAC.qml GetAssignment.qml LoadPage.qml CreateAssignmentComponent.qml CreateAccount.qml service.js Database.js Login.qml MainPage.qml GetAssignments.qml CreateAssignment.qml SearchUsers.qml
resources.prefix = /$${TARGET}
RESOURCES += resources \
    fonts.qrc

INCLUDEPATH += ../KipTrak-Lib/
DESTDIR = $$PWD/../binaries/$$DESTINATION_PATH
LIBS += -L$$PWD/../binaries/$$DESTINATION_PATH -lKipTrak-Lib_armeabi-v7a
ANDROID_EXTRA_LIBS += $$PWD/../binaries/$$DESTINATION_PATH/libKipTrak-Lib_armeabi-v7a.so
ANDROID_EXTRA_LIBS += C:\android-sdk\android_openssl\latest\arm\libcrypto_1_1.so
ANDROID_EXTRA_LIBS += C:\android-sdk\android_openssl\latest\arm\libssl_1_1.so

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    CreateAccount.qml \
    CreateAssignment.qml \
    CreateAssignmentComponent.qml \
    CreateAssignmentDTComponent.qml \
    CreateFlickableAC.qml \
    Database.js \
    Deprecated.qml \
    GetAssignment.qml \
    GetAssignmentPage.qml \
    GetAssignments.qml \
    LoadPage.qml \
    Login.qml \
    MainPage.qml \
    SearchUsers.qml \
    service.js
