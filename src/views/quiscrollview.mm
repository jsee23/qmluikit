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

#include "quiscrollview.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

QUIScrollView::QUIScrollView(QObject* parent)
    : QUIView(false, parent)
{
    m_nativeResource = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,100,20)];
}

QUIScrollView::~QUIScrollView()
{
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UIScrollView)
        [nativeControl release];
    }
}

int QUIScrollView::contentWidth() const
{
    QMLUIKIT_NATIVE_CONTROL(UIScrollView)
    return nativeControl.contentSize.width;
}

void QUIScrollView::setContentWidth(int width)
{
    QMLUIKIT_NATIVE_CONTROL(UIScrollView)

    nativeControl.contentSize = CGSizeMake(width, nativeControl.contentSize.height);
    emit contentWidthChanged();
}

int QUIScrollView::contentHeight() const
{
    QMLUIKIT_NATIVE_CONTROL(UIScrollView)
    return nativeControl.contentSize.height;
}

void QUIScrollView::setContentHeight(int height)
{
    QMLUIKIT_NATIVE_CONTROL(UIScrollView)
    nativeControl.contentSize = CGSizeMake(nativeControl.contentSize.width, height);
    emit contentHeightChanged();
}
