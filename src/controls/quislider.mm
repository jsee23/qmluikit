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

#include "quislider.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISliderEventHandler : NSObject
{
    @public
    QUISlider *control;
}

-(IBAction) valueChanged : (id) sender;
@end

@implementation QUISliderEventHandler
- (IBAction) valueChanged : (id) sender
{
    Q_UNUSED(sender)
    emit control->valueChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUISliderPrivate
{
public:
    QUISliderEventHandler* native;
};

/*!
 * \brief TODO: doc
 * \qmltype UISlider
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UISlider} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUISlider::QUISlider(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISliderPrivate)
{
    d->native = [[QUISliderEventHandler alloc] init];
    m_nativeResource = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [((UISlider*) m_nativeResource)
        addTarget:d->native
        action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUISlider::~QUISlider()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UISlider*) m_nativeResource) release];
}

qreal QUISlider::value() const
{
    return ((UISlider*) m_nativeResource).value;
}

void QUISlider::setValue(qreal value)
{
    [((UISlider*) m_nativeResource) setValue:value animated:TRUE];
}
