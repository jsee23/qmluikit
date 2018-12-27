/****************************************************************************
**
** Copyright (C) 2016 Jochen Seemann
**
** This file is part of the qmluikit library.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
****************************************************************************/

#include <qqml.h>

#include "quiwindow.h"
#include "controllers/quiviewcontroller.h"
#include "controllers/quinavigationcontroller.h"
#include "controllers/quitableviewcontroller.h"
#include "controllers/quitabbarcontroller.h"
#include "controllers/quialertcontroller.h"
#include "views/quiview.h"
#include "views/quilabel.h"
#include "views/quiprogressview.h"
#include "views/quiscrollview.h"
#include "views/quitableviewcell.h"
#include "controls/quicontrol.h"
#include "controls/quibutton.h"
#include "controls/quidatepicker.h"
#include "controls/quisegmentedcontrol.h"
#include "controls/quislider.h"
#include "controls/quiswitch.h"
#include "controls/quitextfield.h"
#include "quitoolbar.h"
#include "quibarbuttonitem.h"
#include "quitabbaritem.h"
#include "quitableviewsection.h"
#include "quialertaction.h"
#include "quinavigationitem.h"

#include <QQmlExtensionPlugin>

QT_BEGIN_NAMESPACE

class QmlUIKitPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    QmlUIKitPlugin(QObject *parent = nullptr) : QQmlExtensionPlugin(parent) {}
    void registerTypes(const char *uri);
};

void QmlUIKitPlugin::registerTypes(const char *uri)
{
    // @uri de.jsee23.uikit
    qmlRegisterType<QUIWindow>(uri, 0, 1, "UIWindow");

    qmlRegisterType<QUIViewController>(uri, 0, 1, "UIViewController");
    qmlRegisterType<QUINavigationController>(uri, 0, 1, "UINavigationController");
    qmlRegisterType<QUITableViewController>(uri, 0, 1, "UITableViewController");
    qmlRegisterType<QUITabBarController>(uri, 0, 1, "UITabBarController");
    qmlRegisterType<QUIAlertController>(uri, 0, 1, "UIAlertController");

    qmlRegisterType<QUIView>(uri, 0, 1, "UIView");
    qmlRegisterType<QUIControl>(uri, 0, 1, "UIControl");
    qmlRegisterType<QUIButton>(uri, 0, 1, "UIButton");
    qmlRegisterType<QUISlider>(uri, 0, 1, "UISlider");
    qmlRegisterType<QUISwitch>(uri, 0, 1, "UISwitch");
    qmlRegisterType<QUITextField>(uri, 0, 1, "UITextField");

    qmlRegisterType<QUILabel>(uri, 0, 1, "UILabel");
    qmlRegisterType<QUIProgressView>(uri, 0, 1, "UIProgressView");
    qmlRegisterType<QUISegmentedControl>(uri, 0, 1, "UISegmentedControl");
    qmlRegisterType<QUIDatePicker>(uri, 0, 1, "UIDatePicker");
    qmlRegisterType<QUIToolbar>(uri, 0, 1, "UIToolbar");
    qmlRegisterType<QUIBarButtonItem>(uri, 0, 1, "UIBarButtonItem");
    qmlRegisterType<QUITabBarItem>(uri, 0, 1, "UITabBarItem");
    qmlRegisterType<QUIScrollView>(uri, 0, 1, "UIScrollView");
    qmlRegisterType<QUIAlertAction>(uri, 0, 1, "UIAlertAction");

    qmlRegisterType<QUITableViewSection>(uri, 0, 1, "UITableViewSection");
    qmlRegisterType<QUITableViewCell>(uri, 0, 1, "UITableViewCell");

    qmlRegisterUncreatableType<QUINavigationItem>(uri, 0, 1, "UINavigationItem", "reason: TODO!");
}

QT_END_NAMESPACE

#include "qmluikit_plugin.moc"


