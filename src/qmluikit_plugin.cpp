#include "qmluikit_plugin.h"
#include <qqml.h>

#include "quiwindow.h"
#include "controllers/quiviewcontroller.h"
#include "controllers/quinavigationcontroller.h"
#include "controllers/quitableviewcontroller.h"
#include "views/quiview.h"
#include "views/quiprogressview.h"
#include "views/quiscrollview.h"
#include "controls/quicontrol.h"
#include "controls/quibutton.h"
#include "controls/quidatepicker.h"
#include "controls/quisegmentedcontrol.h"
#include "controls/quislider.h"
#include "controls/quiswitch.h"
#include "quitoolbar.h"
#include "quibarbuttonitem.h"
#include "quitableviewsection.h"
#include "quitableviewcell.h"

void QmlUIKitPlugin::registerTypes(const char *uri)
{
    // @uri de.jsee23.uikit
    qmlRegisterType<QUIWindow>(uri, 1, 0, "UIWindow");

    qmlRegisterType<QUIViewController>(uri, 1, 0, "UIViewController");
    qmlRegisterType<QUINavigationController>(uri, 1, 0, "UINavigationController");
    qmlRegisterType<QUITableViewController>(uri, 1, 0, "UITableViewController");

    qmlRegisterType<QUIView>(uri, 1, 0, "UIView");
    qmlRegisterType<QUIControl>(uri, 1, 0, "UIControl");
    qmlRegisterType<QUIButton>(uri, 1, 0, "UIButton");
    qmlRegisterType<QUISwitch>(uri, 1, 0, "UISwitch");
    qmlRegisterType<QUISlider>(uri, 1, 0, "UISlider");
    qmlRegisterType<QUIProgressView>(uri, 1, 0, "UIProgressView");
    qmlRegisterType<QUISegmentedControl>(uri, 1, 0, "UISegmentedControl");
    qmlRegisterType<QUIDatePicker>(uri, 1, 0, "UIDatePicker");
    qmlRegisterType<QUIToolbar>(uri, 1, 0, "UIToolbar");
    qmlRegisterType<QUIBarButtonItem>(uri, 1, 0, "UIBarButtonItem");
    qmlRegisterType<QUIScrollView>(uri, 1, 0, "UIScrollView");

    qmlRegisterType<QUITableViewSection>(uri, 1, 0, "UITableViewSection");
    qmlRegisterType<QUITableViewCell>(uri, 1, 0, "UITableViewCell");
}


