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

#include "qmluikit_plugin.h"
#include <qqml.h>

#include "quiwindow.h"
#include "controllers/quiviewcontroller.h"
#include "controllers/quinavigationcontroller.h"
#include "controllers/quitableviewcontroller.h"
#include "controllers/quitabbarcontroller.h"
#include "views/quiview.h"
#include "views/quiprogressview.h"
#include "views/quiscrollview.h"
#include "views/quitableviewcell.h"
#include "controls/quicontrol.h"
#include "controls/quibutton.h"
#include "controls/quidatepicker.h"
#include "controls/quisegmentedcontrol.h"
#include "controls/quislider.h"
#include "controls/quiswitch.h"
#include "quitoolbar.h"
#include "quibarbuttonitem.h"
#include "quitableviewsection.h"

void QmlUIKitPlugin::registerTypes(const char *uri)
{
    // @uri de.jsee23.uikit
    qmlRegisterType<QUIWindow>(uri, 0, 1, "UIWindow");

    qmlRegisterType<QUIViewController>(uri, 0, 1, "UIViewController");
    qmlRegisterType<QUINavigationController>(uri, 0, 1, "UINavigationController");
    qmlRegisterType<QUITableViewController>(uri, 0, 1, "UITableViewController");
    qmlRegisterType<QUITabBarController>(uri, 0, 1, "UITabBarController");

    qmlRegisterType<QUIView>(uri, 0, 1, "UIView");
    qmlRegisterType<QUIControl>(uri, 0, 1, "UIControl");
    qmlRegisterType<QUIButton>(uri, 0, 1, "UIButton");
    qmlRegisterType<QUISwitch>(uri, 0, 1, "UISwitch");
    qmlRegisterType<QUISlider>(uri, 0, 1, "UISlider");
    qmlRegisterType<QUIProgressView>(uri, 0, 1, "UIProgressView");
    qmlRegisterType<QUISegmentedControl>(uri, 0, 1, "UISegmentedControl");
    qmlRegisterType<QUIDatePicker>(uri, 0, 1, "UIDatePicker");
    qmlRegisterType<QUIToolbar>(uri, 0, 1, "UIToolbar");
    qmlRegisterType<QUIBarButtonItem>(uri, 0, 1, "UIBarButtonItem");
    qmlRegisterType<QUIScrollView>(uri, 0, 1, "UIScrollView");

    qmlRegisterType<QUITableViewSection>(uri, 0, 1, "UITableViewSection");
    qmlRegisterType<QUITableViewCell>(uri, 0, 1, "UITableViewCell");
}


