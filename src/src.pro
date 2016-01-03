TARGET  = qmluikit
TARGETPATH = de/jsee23/qmluikit
IMPORT_VERSION = 1.0

QT += qml

OTHER_FILES = \
    qmldir \
    plugins.qmltypes

DEFINES += __x86_64__

# Input
SOURCES += \
    qmluikit_plugin.cpp \
    quikititem.cpp \
    quitableviewsection.cpp

OBJECTIVE_SOURCES += \
    controllers/quiviewcontroller.mm \
    controllers/quinavigationcontroller.mm \
    controllers/quitableviewcontroller.mm \
    views/quiview.mm \
    views/quiprogressview.mm \
    views/quiscrollview.mm \
    controls/quicontrol.mm \
    controls/quibutton.mm \
    controls/quidatepicker.mm \
    controls/quisegmentedcontrol.mm \
    controls/quislider.mm \
    controls/quiswitch.mm \
    quiwindow.mm \
    quikithelpers.mm \
    quitoolbar.mm \
    quibarbuttonitem.mm \
    quitableviewcell.mm

HEADERS += \
    qmluikit_plugin.h \
    controllers/quiviewcontroller.h \
    controllers/quinavigationcontroller.h \
    controllers/quitableviewcontroller.h \
    views/quiview.h \
    views/quiprogressview.h \
    views/quiscrollview.h \
    controls/quicontrol.h \
    controls/quibutton.h \
    controls/quidatepicker.h \
    controls/quisegmentedcontrol.h \
    controls/quislider.h \
    controls/quiswitch.h \
    quiwindow.h \
    quikititem.h \
    quikithelpers.h \
    quitoolbar.h \
    quibarbuttonitem.h \
    quitableviewsection.h \
    quitableviewcell.h

CONFIG += no_cxx_module
load(qml_plugin)

