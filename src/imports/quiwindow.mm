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

#include "quiwindow.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

/*!
 * \brief Provides a top-level application window
 * \qmltype UIWindow
 * \inqmlmodule jsee23.qmluikit
 *
 * UIWindow is the top-level object of an application and simply specify, which
 * view controller will be loaded at startup.
 *
 * UIWindow expect a UIViewController or subtype as a child. Note, that only
 * one child is supported!
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * UIWindow {
 *     UIViewController {
 *         id: initialShownViewController
 *         // ...
 *     }
 * }
 * \endqml
 */

class QUIWindowPrivate {
public:
    UIScreen* m_screen;
    bool foundInitialViewController;
};

QUIWindow::QUIWindow(QObject *parent)
    : QUIView(false, parent),
      d(new QUIWindowPrivate)
{
    d->foundInitialViewController = false;

    d->m_screen = [UIScreen mainScreen];
    m_nativeResource = [[UIWindow alloc] initWithFrame:[d->m_screen bounds]];

    QMLUIKIT_NATIVE_CONTROL(UIWindow)
    nativeControl.screen = d->m_screen;
    nativeControl.backgroundColor = [UIColor whiteColor];

    [nativeControl makeKeyAndVisible];
}

QUIWindow::~QUIWindow()
{
    QMLUIKIT_NATIVE_CONTROL(UIWindow)
    [nativeControl release];
}

void QUIWindow::childrenDidChanged()
{
    if (d->foundInitialViewController)
        return;

    QMLUIKIT_NATIVE_CONTROL(UIWindow)
    for (int i = 0; i < m_children.size(); i++) {
        QUIViewController* controller = qobject_cast<QUIViewController*>(m_children.at(i));
        if (controller && controller->nativeItem()) {
            nativeControl.rootViewController = static_cast<UIViewController*>(controller->nativeItem());
            d->foundInitialViewController = true;
        }
    }
}
