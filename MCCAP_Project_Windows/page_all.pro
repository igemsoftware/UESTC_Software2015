TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    organismhdl.cpp \
    clusterhdl.cpp \
    maincontroller.cpp \
    ogcontroller.cpp \
    serverconnector.cpp \
    clustercontroller.cpp

RESOURCES += qml.qrc \
    help.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    organismhdl.h \
    clusterhdl.h \
    maincontroller.h \
    ogcontroller.h \
    serverconnector.h \
    clustercontroller.h

RC_FILE = icon.rc
