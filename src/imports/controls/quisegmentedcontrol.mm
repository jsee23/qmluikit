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

#include "quisegmentedcontrol.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISegmentedControlEventHandler : NSObject
{
    @public
    QUISegmentedControl *control;
}

- (void) currentIndexChanged : (UISegmentedControl*) segment;
@end

@implementation QUISegmentedControlEventHandler
- (void) currentIndexChanged : (UISegmentedControl*) segment
{
    Q_UNUSED(segment)
    emit control->selectedSegmentChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUISegmentedControlPrivate
{
public:
    QUISegmentedControlEventHandler* native;
    QStringList items;
    int initialSelectedSegment;
    bool componentCompleted;
};

/*!
 * \brief TODO: doc
 * \qmltype UISegmentedControl
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UISegmentedControl} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUISegmentedControl::QUISegmentedControl(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISegmentedControlPrivate)
{
    d->native = [[QUISegmentedControlEventHandler alloc] init];
    m_nativeResource = [[UISegmentedControl alloc] initWithItems:nil];

    QMLUIKIT_NATIVE_CONTROL(UISegmentedControl)
    [nativeControl addTarget:d->native action:@selector(currentIndexChanged:)
                   forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
    d->componentCompleted = false;
    d->initialSelectedSegment = -1;
}

QUISegmentedControl::~QUISegmentedControl()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UISegmentedControl)
        [nativeControl release];
    }
}

QStringList QUISegmentedControl::items() const
{
    return d->items;
}

void QUISegmentedControl::setItems(const QStringList &items)
{
    QMLUIKIT_NATIVE_CONTROL(UISegmentedControl)

    d->items = items;
    [nativeControl removeAllSegments];
    for (int i=0; i < items.size(); i++)
        [nativeControl insertSegmentWithTitle:items.at(i).toNSString() atIndex:i animated:FALSE];
}

int QUISegmentedControl::selectedSegment() const
{
    QMLUIKIT_NATIVE_CONTROL(UISegmentedControl)
    return nativeControl.selectedSegmentIndex;
}

int QUISegmentedControl::initialSelectedSegment() const
{
    return d->initialSelectedSegment;
}

void QUISegmentedControl::setInitialSelectedSegment(int index)
{
    if (index == d->initialSelectedSegment)
        return;

    d->initialSelectedSegment = index;
    emit initialSelectedSegmentChanged();
}

void QUISegmentedControl::componentComplete()
{
    d->componentCompleted = true;
    if (d->initialSelectedSegment >= 0) {
        QMLUIKIT_NATIVE_CONTROL(UISegmentedControl)
        nativeControl.selectedSegmentIndex = d->initialSelectedSegment;
        emit selectedSegmentChanged();
    }
}
