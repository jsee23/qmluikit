#include "qmluikit_plugin.h"
#include <qqml.h>

#include "quiwindow.h"
#include "quiviewcontroller.h"
#include "quinavigationcontroller.h"
#include "quiview.h"
#include "quicontrol.h"
#include "quibutton.h"
#include "quiswitch.h"
#include "quislider.h"
#include "quiprogressview.h"
#include "quisegmentedcontrol.h"
#include "quidatepicker.h"
#include "quitoolbar.h"
#include "quibarbuttonitem.h"

void SrcPlugin::registerTypes(const char *uri)
{
    // @uri de.jsee23.uikit
    qmlRegisterType<QUIWindow>(uri, 1, 0, "UIWindow");
    qmlRegisterType<QUIViewController>(uri, 1, 0, "UIViewController");
    qmlRegisterType<QUINavigationController>(uri, 1, 0, "UINavigationController");

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
}


