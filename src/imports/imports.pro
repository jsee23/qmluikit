TARGET  = qmluikit
TARGETPATH = jsee23/qmluikit
IMPORT_VERSION = 0.1

QT += qml qml-private
LIBS += -framework UIKit
CONFIG += no_app_extension_api_only

OTHER_FILES = \
    qmldir \
    plugins.qmltypes

SOURCES += \
    qmluikit_plugin.cpp \
    quikititem.cpp \
    quitableviewsection.cpp

OBJECTIVE_SOURCES += \
    controllers/quiviewcontroller.mm \
    controllers/quinavigationcontroller.mm \
    controllers/quitableviewcontroller.mm \
    controllers/quitabbarcontroller.mm \
    controllers/quialertcontroller.mm \
    views/quilabel.mm \
    views/quiview.mm \
    views/quiprogressview.mm \
    views/quiscrollview.mm \
    views/quitableviewcell.mm \
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
    quitabbaritem.mm \
    quialertaction.mm \
    quinavigationitem.mm

HEADERS += \
    controllers/quiviewcontroller.h \
    controllers/quinavigationcontroller.h \
    controllers/quitableviewcontroller.h \
    controllers/quitabbarcontroller.h \
    controllers/quialertcontroller.h \
    views/quiview.h \
    views/quilabel.h \
    views/quiprogressview.h \
    views/quiscrollview.h \
    views/quitableviewcell.h \
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
    quitabbaritem.h \
    quialertaction.h \
    quinavigationitem.h

CONFIG += no_cxx_module static
DEFINES += QT_STATICPLUGIN
load(qml_plugin)

