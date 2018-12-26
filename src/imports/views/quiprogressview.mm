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

#include "quiprogressview.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

QUIProgressView::QUIProgressView(QObject* parent)
    : QUIView(false, parent)
{
    m_nativeResource = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    QMLUIKIT_NATIVE_CONTROL(UIProgressView)
    nativeControl.frame = CGRectMake(0,0,100,20);

    m_progressAnimated = true;
}

QUIProgressView::~QUIProgressView()
{
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UIProgressView)
        [nativeControl release];
    }
}

qreal QUIProgressView::progress() const
{
    QMLUIKIT_NATIVE_CONTROL(UIProgressView)
    return nativeControl.progress;
}

void QUIProgressView::setProgress(qreal progress)
{
    QMLUIKIT_NATIVE_CONTROL(UIProgressView)
    [nativeControl setProgress:progress animated:m_progressAnimated];
}

bool QUIProgressView::progressAnimated() const
{
    return m_progressAnimated;
}

void QUIProgressView::setProgressAnimated(bool animated)
{
    if (animated == m_progressAnimated)
        return;

    m_progressAnimated = animated;
    emit progressAnimatedChanged();
}

