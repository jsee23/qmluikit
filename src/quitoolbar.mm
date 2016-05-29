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

#include "quitoolbar.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

#include "quibarbuttonitem.h"

class QUIToolbarPrivate
{
public:
    NSMutableArray* items;
};

QUIToolbar::QUIToolbar(QObject* parent)
    : QUIView(false, parent),
      d(new QUIToolbarPrivate)
{
    m_nativeResource = [[UIToolbar alloc] init];
    ((UIToolbar*) m_nativeResource).frame = CGRectMake(0,0,100,20);
    d->items = [[NSMutableArray alloc] init];
}

QUIToolbar::~QUIToolbar()
{
    [((UIToolbar*) m_nativeResource) release];
    [d->items release];
}

void QUIToolbar::childrenDidChanged()
{
    // clearing array
    [d->items removeAllObjects];

    // appending children
    for (int i=0; i < m_children.size(); i++) {
        QUIBarButtonItem *view = qobject_cast<QUIBarButtonItem*>(m_children.at(i));
        if (view && view->nativeItem())
            [d->items addObject:((UIBarButtonItem*) view->nativeItem())];
    }

    // setting new array
    [((UIToolbar*) m_nativeResource) setItems:d->items animated:NO];
}
