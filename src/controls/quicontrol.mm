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

#include "quicontrol.h"

#include <UIKit/UIKit.h>

QUIControl::QUIControl(QObject* parent) :
    QUIView(false, parent)
{
    m_nativeResource = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIControl::QUIControl(bool init, QObject *parent) :
    QUIView(false, parent)
{
    if (init)
        m_nativeResource = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIControl::~QUIControl()
{
    if (m_nativeResource)
        [((UIControl*) m_nativeResource) release];
}
