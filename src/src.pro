TEMPLATE = lib
TARGET = src
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = de.jsee23.uikit

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

DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

