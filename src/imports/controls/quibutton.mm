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

#include "quibutton.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUIButtonEventHandler : NSObject
{
    @public
    QUIButton *button;
}

-(IBAction) clicked : (id) sender;
@end

@implementation QUIButtonEventHandler
- (IBAction) clicked : (id) sender
{
    Q_UNUSED(sender);
    emit button->clicked();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUIButtonPrivate
{
public:
    QUIButtonEventHandler* native;
};


/*!
 * \brief TODO: doc
 * \qmltype UIButton
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UIButton} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUIButton::QUIButton(QObject *parent)
    : QUIControl(false, parent)
    , d(new QUIButtonPrivate)
{
    d->native = [[QUIButtonEventHandler alloc] init];
    m_nativeResource = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    QMLUIKIT_NATIVE_CONTROL(UIButton)
    [nativeControl setFrame: CGRectMake(0, 0, 100, 40)];
    [nativeControl addTarget:d->native action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    d->native->button = this;
}

QUIButton::~QUIButton()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UIButton)
        [nativeControl release];
    }
}

QString QUIButton::titleLabel() const
{
    QMLUIKIT_NATIVE_CONTROL(UIButton)
    return QString::fromNSString(nativeControl.currentTitle);
}

void QUIButton::setTitleLabel(const QString &title)
{
    QMLUIKIT_NATIVE_CONTROL(UIButton)
    [nativeControl setTitle:title.toNSString() forState:UIControlStateNormal];
}
