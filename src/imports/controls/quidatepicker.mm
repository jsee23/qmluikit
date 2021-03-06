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

#include "quidatepicker.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUIDatePickerEventHandler : NSObject
{
    @public
    QUIDatePicker *control;
}
@end

@implementation QUIDatePickerEventHandler
- (IBAction) valueChanged : (id) sender
{
    Q_UNUSED(sender)
    emit control->dateChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUIDatePickerPrivate
{
public:
    QUIDatePickerEventHandler* native;
};

/*!
 * \brief TODO: doc
 * \qmltype UIDatePicker
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UIDatePicker} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUIDatePicker::QUIDatePicker(QObject* parent)
    : QUIControl(false, parent),
      d(new QUIDatePickerPrivate)
{
    d->native = [[QUIDatePickerEventHandler alloc] init];
    m_nativeResource = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];

    QMLUIKIT_NATIVE_CONTROL(UIDatePicker)
    [nativeControl addTarget:d->native action:@selector(valueChanged:)
                   forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUIDatePicker::~QUIDatePicker()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UIDatePicker)
        [nativeControl release];
    }
}

QDateTime QUIDatePicker::date() const
{
    // ToDo!!!
    return QDateTime();
}
