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

#include "quitabbarcontroller.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

@interface QNative_UITabBarController : UITabBarController
{
    @public
    QUITabBarController* control;
}
@end

@implementation QNative_UITabBarController
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

// TODO:
//    control->setStatusBarHeight(MIN([UIApplication sharedApplication].statusBarFrame.size.height,
//                              [UIApplication sharedApplication].statusBarFrame.size.width));
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
    \qmltype UITabBarViewController
    \inherits UIViewController
    \inqmlmodule jsee23.qmluikit
    \brief Provides a container for displaying multiple \l {UIViewController} through a tab bar.

    \l {UITabBarViewController} ... TODO

    \qml
    import jsee23.qmluikit 0.1

    UITabBarController {
        UIViewController {
            title: "First"
            tabBarItem: UITabBarItem {
                title: "First"
                systemItem: UITabBarItem.Contacts
            }

            UIView {
                backgroundColor: "red"
            }
        }

        UIViewController {
            title: "Second"
            tabBarItem: UITabBarItem {
                title: "Second"
                systemItem: UITabBarItem.Recents
            }

            UIView {
                backgroundColor: "green"
            }
        }
    }
    \endqml
*/



QUITabBarController::QUITabBarController(QObject *parent)
    : QUIViewController(false, parent)
{
    initNativeResource();
    QMLUIKIT_QT_CONTROL(UITabBarController)
    m_navigationItem = new QUINavigationItem(qtControl.navigationItem, this);
}

QUITabBarController::~QUITabBarController()
{
    if (m_nativeResource) {
        QMLUIKIT_QT_CONTROL(UITabBarController)
        [qtControl release];
    }
}

void QUITabBarController::childrenDidChanged()
{
    QMLUIKIT_QT_CONTROL(UITabBarController)

    NSMutableArray * controllers = [[NSMutableArray alloc] initWithCapacity:m_children.size()];
    for (int i = 0; i < m_children.size(); i++) {
        QUIViewController* item = qobject_cast<QUIViewController*>(m_children.at(i));
        if (item && item->nativeItem())
            [controllers addObject: ((QNative_UITabBarController*)item->nativeItem())];
    }

    qtControl.viewControllers = controllers;
}

void QUITabBarController::initNativeResource()
{
    m_nativeResource = [[QNative_UITabBarController alloc] init];
    QMLUIKIT_QT_CONTROL(UITabBarController)
    qtControl->control = this;

    m_controllerView = new QUIView(qtControl.view, this);
}
