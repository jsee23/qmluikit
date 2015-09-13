TARGET  = qmluikit
TARGETPATH = de/jsee23/qmluikit
IMPORT_VERSION = 1.0

QT += qml quick

OTHER_FILES = qmldir

# Input
SOURCES += \
    qmluikit_plugin.cpp

OBJECTIVE_SOURCES += \
    quiviewcontroller.mm \
    quiwindow.mm \
    quibutton.mm \
    quiview.mm \
    quicontrol.mm \
    quinavigationcontroller.mm \
    quiswitch.mm \
    quislider.mm \
    quiprogressview.mm \
    quisegmentedcontrol.mm \
    quikithelpers.mm \
    quidatepicker.mm \
    quitoolbar.mm \
    quibarbuttonitem.mm

HEADERS += \
    qmluikit_plugin.h \
    quiviewcontroller.h \
    quiwindow.h \
    quikititem.h \
    quibutton.h \
    quiview.h \
    quicontrol.h \
    quinavigationcontroller.h \
    quiswitch.h \
    quislider.h \
    quiprogressview.h \
    quikithelpers.h \
    quisegmentedcontrol.h \
    quidatepicker.h \
    quitoolbar.h \
    quibarbuttonitem.h

CONFIG += no_cxx_module
load(qml_plugin)

