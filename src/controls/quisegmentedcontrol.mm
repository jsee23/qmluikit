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

QUISegmentedControl::QUISegmentedControl(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISegmentedControlPrivate)
{
    d->native = [[QUISegmentedControlEventHandler alloc] init];
    m_nativeResource = [[UISegmentedControl alloc] initWithItems:nil];
    [((UISegmentedControl*) m_nativeResource)
        addTarget:d->native
        action:@selector(currentIndexChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
    d->componentCompleted = false;
    d->initialSelectedSegment = -1;
}

QUISegmentedControl::~QUISegmentedControl()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UISegmentedControl*) m_nativeResource) release];
}

QStringList QUISegmentedControl::items() const
{
    return d->items;
}

void QUISegmentedControl::setItems(const QStringList &items)
{
    d->items = items;
    [((UISegmentedControl*) m_nativeResource) removeAllSegments];
    for (int i=0; i < items.size(); i++)
        [((UISegmentedControl*) m_nativeResource) insertSegmentWithTitle:items.at(i).toNSString()
            atIndex:i animated:FALSE];
}

int QUISegmentedControl::selectedSegment() const
{
    return ((UISegmentedControl*) m_nativeResource).selectedSegmentIndex;
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
        ((UISegmentedControl*) m_nativeResource).selectedSegmentIndex = d->initialSelectedSegment;
        emit selectedSegmentChanged();
    }
}
