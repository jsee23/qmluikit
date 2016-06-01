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

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

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

//////////////////////////
// Qt
//////////////////////////

/*!
 * \brief TODO: doc
 * \qmltype UINavigationController
 * \inqmlmodule jsee23.qmluikit
 *
 * TODO
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * UIWindow {
 *     // TODO: doc
 * }
 * \endqml
 */

QUINavigationController::QUINavigationController(QObject* parent) :
    QUIViewController(false, parent)
{
    initNativeResource();
}

QUINavigationController::~QUINavigationController()
{
    if (m_nativeResource)
        [((QNative_UINavigationController*) m_nativeResource) release];
}

void QUINavigationController::initNativeResource()
{
    m_nativeResource = [[QNative_UINavigationController alloc] init];
    ((QNative_UINavigationController*) m_nativeResource)->control = this;

    m_controllerView = new QUIView(((QNative_UINavigationController*) m_nativeResource).view, this);
}

void QUINavigationController::childrenDidChanged()
{
}

QUIViewController* QUINavigationController::initialViewController() const
{
    return m_initialViewController;
}

void QUINavigationController::setInitialViewController(QUIViewController *controller)
{
    m_initialViewController = controller;
    [((UINavigationController*) m_nativeResource)
            pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];

    emit initialViewControllerChanged();
}

/*!
 * \qmlmethod void jsee23.qmluikit::UINavigationController::pushViewController(UIViewController* controller)
 *
 * TODO: doc
 */
void QUINavigationController::pushViewController(QUIViewController* controller)
{
    controller->setSize(QSize(width(), height()));
    [((UINavigationController*) m_nativeResource)
            pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];
//    // check navigation bar and its height
//    emit navigationBarGeometryChanged();
}

