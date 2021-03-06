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

#include <UIKit/UIKit.h>
#include <QSize>

#include "quiviewcontroller.h"
#include "quialertcontroller.h"
#include "quikithelpers.h"

@interface QNative_UIViewController : UIViewController
{
    @public
    QUIViewController* control;
}
@end

@implementation QNative_UIViewController
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(int(size.width), int(size.height)));
}

@end

#include "../views/quiview.h"

/*!
    \brief TODO: doc
    \qmltype UIViewController
    \inqmlmodule jsee23.qmluikit

    UIViewController is the common container for a page of your application. It
    typically fill out the whole screen and contains views and controls.

    \qml
    import jsee23.qmluikit 0.1

    //...
    UIViewController {
        title: "My Super App"

        UIButton {
            //...
        }

        UISlider {
            //...
        }

        //...
    }
    //...

    \endqml
*/

class QUIViewControllerPrivate
{
public:
    QSize m_size;
    QString m_title;
};

QUIViewController::QUIViewController(QObject *parent)
    : QUIKitItem(parent)
    , d(new QUIViewControllerPrivate)
    , m_controllerView(nullptr)
    , m_tabBarItem(nullptr)
{
    QMLUIKIT_QT_CONTROL(UIViewController)
    initNativeResource();
    void* item = qtControl.navigationItem;
    m_navigationItem = new QUINavigationItem(item, this);
}

QUIViewController::QUIViewController(bool init, QObject *parent)
    : QUIKitItem(parent)
    , d(new QUIViewControllerPrivate)
    , m_controllerView(nullptr)
    , m_tabBarItem(nullptr)
{
    if (init) {
        QMLUIKIT_QT_CONTROL(UIViewController)
        initNativeResource();
        void* item = qtControl.navigationItem;
        m_navigationItem = new QUINavigationItem(item, this);
    }
}

void QUIViewController::initNativeResource()
{
    m_nativeResource = [[QNative_UIViewController alloc] init];
    QMLUIKIT_QT_CONTROL(UIViewController)
    qtControl->control = this;

    CGSize size = qtControl.view.frame.size;
    d->m_size = QSize(size.width, size.height);

    m_controllerView = new QUIView(qtControl.view, this);
}

QUIViewController::~QUIViewController()
{
    QMLUIKIT_QT_CONTROL(UIViewController)
    [qtControl release];
}

void* QUIViewController::nativeItem()
{
    return m_nativeResource;
}

void QUIViewController::componentComplete()
{
    m_componentCompleted = true;

    setTitle(d->m_title);
}

void QUIViewController::childrenDidChanged()
{
    QMLUIKIT_NATIVE_CONTROL(UIViewController)

    for (int i=0; i < m_children.size(); i++) {
        QUIView *view = qobject_cast<QUIView*>(m_children.at(i));
        if (view && view->nativeItem()) {
            [nativeControl.view addSubview:(UIView*)view->nativeItem()];
            continue;
        }
    }
}

/*!
    \qmlproperty string jsee23.qmluikit::UIViewController::title

    TODO: doc
*/
QString QUIViewController::title() const
{
    return d->m_title;
}

void QUIViewController::setTitle(const QString &title)
{
    QMLUIKIT_NATIVE_CONTROL(UIViewController)

    d->m_title = title;
    emit titleChanged();

    if (!m_componentCompleted)
        return;

    if (nativeControl.navigationItem) {
        [nativeControl.navigationItem setTitle:title.toNSString()];
    }
}

/*!
    \qmlproperty int jsee23.qmluikit::UIViewController::width
    \readonly

    TODO: doc
*/
int QUIViewController::width() const
{
    return d->m_size.width();
}

/*!
    \qmlproperty int jsee23.qmluikit::UIViewController::height
    \readonly

    TODO: doc
*/
int QUIViewController::height() const
{
    return d->m_size.height();
}

void QUIViewController::setSize(const QSize &size)
{
    if (size == d->m_size)
        return;

    d->m_size = size;
    emit widthChanged();
    emit heightChanged();
}

/*!
    \qmlproperty size jsee23.qmluikit::UIViewController::navigationBarGeometry
    \readonly

    TODO: doc
*/
QRect QUIViewController::navigationBarGeometry() const
{
    QMLUIKIT_NATIVE_CONTROL(UINavigationController)
    if (!nativeControl.navigationBar)
        return QRect();

    int x = nativeControl.navigationBar.frame.origin.x;
    int y = nativeControl.navigationBar.frame.origin.y;
    int width = nativeControl.navigationBar.frame.size.width;
    int height = nativeControl.navigationBar.frame.size.height;
    return QRect(x, y, width, height);
}

/*!
    \qmlproperty int jsee23.qmluikit::UIViewController::statusBarHeight
    \readonly

    TODO: doc
*/
int QUIViewController::statusBarHeight() const
{
    return m_statusBarHeight;
}

void QUIViewController::setStatusBarHeight(int height)
{
    if (height == m_statusBarHeight)
        return;

    m_statusBarHeight = height;
    emit statusBarHeightChanged();
}

/*!
    \qmlproperty UIView jsee23.qmluikit::UIViewController::view
    \readonly

    TODO: doc
*/
QUIView *QUIViewController::view() const
{
    return m_controllerView;
}

/*!
    \qmlproperty UITabBarItem jsee23.qmluikit::UIViewController::tabBarItem

    TODO: doc
*/
QUITabBarItem *QUIViewController::tabBarItem() const
{
    return m_tabBarItem;
}

void QUIViewController::setTabBarItem(QUITabBarItem *item)
{
    if (item == m_tabBarItem)
        return;

    m_tabBarItem = item;
    emit tabBarItemChanged();

    item->setTargetViewController(this);
}

/*!
    \qmlproperty UINavigationItem jsee23.qmluikit::UIViewController::navigationItem

    TODO: doc
*/
QUINavigationItem *QUIViewController::navigationItem() const
{
    return m_navigationItem;
}

/*!
    \qmlmethod void jsee23.qmluikit::UIViewController::presentViewController(UIViewController *controller)

    TODO: doc
*/
void QUIViewController::presentViewController(QUIViewController *controller)
{
    QMLUIKIT_NATIVE_CONTROL(UINavigationController)

    QUIAlertController* alertController = qobject_cast<QUIAlertController*>(controller);
    if (!alertController) {
        [nativeControl presentViewController:((UIViewController*) controller->nativeItem()) animated:YES completion:nil];
    } else {
        alertController->createControllerAndPresent(this);
    }
}
