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

#include "quinavigationcontroller.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

#define AF_APP_EXTENSIONS

@interface QNative_UINavigationController : UINavigationController
{
    @public
    QUINavigationController* control;
}
@end

@implementation QNative_UINavigationController
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(size.width, size.height));
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGSize size = self.view.frame.size;
    control->setSize(QSize(size.width, size.height));
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    emit control->navigationBarGeometryChanged();
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(statusFrameChanged:)
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];

    control->setStatusBarHeight(MIN([UIApplication sharedApplication].statusBarFrame.size.height,
                              [UIApplication sharedApplication].statusBarFrame.size.width));
}
- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]
        removeObserver:self
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];
    [super viewDidUnload];
}

- (void) statusFrameChanged:(NSNotification*)note
{
    CGRect statusBarFrame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    control->setStatusBarHeight(MIN(statusBarFrame.size.height,
                               statusBarFrame.size.width));
}
@end

/*!
    \qmltype UINavigationController
    \inherits UIViewController
    \inqmlmodule jsee23.qmluikit
    \brief Provides a container for navigating between different \l {ViewController}s.

    TODO

    \qml
    import jsee23.qmluikit 0.1

    UIWindow {
        UINavigationController {
            id: navController

            initialViewController: UIViewController {
                title: "Landing page"
                // ...

                UIButton {
                    titleLable: "go to 2. page"
                    onClicked: navController.pushViewController(navController.secondPage)
                }
            }

            property UIViewController secondPage: UIViewController {
                // ...
            }
        }
    }
    \endqml
*/

QUINavigationController::QUINavigationController(QObject* parent) :
    QUIViewController(false, parent)
{
    initNativeResource();
}

QUINavigationController::~QUINavigationController()
{
    if (m_nativeResource) {
        QMLUIKIT_QT_CONTROL(UINavigationController)
        [qtControl release];
    }
}

void QUINavigationController::initNativeResource()
{
    m_nativeResource = [[QNative_UINavigationController alloc] init];
    QMLUIKIT_QT_CONTROL(UINavigationController)
    qtControl->control = this;

    m_controllerView = new QUIView(qtControl.view, this);
}

void QUINavigationController::childrenDidChanged()
{
}

/*!
    \qmlproperty UIViewController jsee23.qmluikit::UINavigationController::initialViewController
    TODO: doc
*/
QUIViewController* QUINavigationController::initialViewController() const
{
    return m_initialViewController;
}

void QUINavigationController::setInitialViewController(QUIViewController *controller)
{
    QMLUIKIT_NATIVE_CONTROL(UINavigationController)

    m_initialViewController = controller;
    [nativeControl pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];

    emit initialViewControllerChanged();
}

/*!
    \qmlmethod void jsee23.qmluikit::UINavigationController::pushViewController(UIViewController* controller)
    TODO: doc
*/
void QUINavigationController::pushViewController(QUIViewController* controller)
{
    QMLUIKIT_NATIVE_CONTROL(UINavigationController)

    controller->setSize(QSize(width(), height()));
    [nativeControl pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];
//    // check navigation bar and its height
//    emit navigationBarGeometryChanged();
}

