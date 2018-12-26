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

#include "quiview.h"

#include <UIKit/UIKit.h>

#include "quikithelpers.h"

QUIView::QUIView(QObject* parent) :
    QUIKitItem(parent)
{
    m_nativeResource = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    m_backgroundColor = QColor::fromRgb(0,0,0);
}

QUIView::QUIView(void *controllerRoot, QObject *parent) :
    QUIKitItem(parent)
{
    m_nativeResource = controllerRoot;
}

QUIView::QUIView(bool init, QObject *parent) :
    QUIKitItem(parent)
{
    if (init)
        m_nativeResource = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIView::~QUIView()
{
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UIView)
        [nativeControl release];
    }
}

void* QUIView::nativeItem()
{
    return m_nativeResource;
}

void QUIView::childrenDidChanged()
{
    QMLUIKIT_NATIVE_CONTROL(UIView)

    for (int i=0; i < m_children.size(); i++) {
        QUIView *view = qobject_cast<QUIView*>(m_children.at(i));
        if (view && view->nativeItem()) {
            [nativeControl addSubview:(UIView*)view->nativeItem()];
            continue;
        }
    }
}

int QUIView::x() const
{
    QMLUIKIT_NATIVE_CONTROL(UIView)
    return nativeControl.frame.origin.x;
}

void QUIView::setX(int x)
{
    QMLUIKIT_NATIVE_CONTROL(UIView)

    CGRect frame = nativeControl.frame;
    frame.origin.x = x;
    [nativeControl setFrame:frame];

    emit xChanged();
}

int QUIView::y() const
{
    QMLUIKIT_NATIVE_CONTROL(UIView)
    return nativeControl.frame.origin.y;
}

void QUIView::setY(int y)
{
    QMLUIKIT_NATIVE_CONTROL(UIView)

    CGRect frame = nativeControl.frame;
    frame.origin.y = y;
    [nativeControl setFrame:frame];

    emit yChanged();
}

int QUIView::width() const
{
    QMLUIKIT_NATIVE_CONTROL(UIView)
    return nativeControl.frame.size.width;
}

void QUIView::setWidth(int width)
{
    QMLUIKIT_NATIVE_CONTROL(UIView)

    CGRect frame = nativeControl.frame;
    frame.size.width = width;
    [nativeControl setFrame:frame];

    emit widthChanged();
}

int QUIView::height() const
{
    QMLUIKIT_NATIVE_CONTROL(UIView)
    return nativeControl.frame.size.height;
}

void QUIView::setHeight(int height)
{
    QMLUIKIT_NATIVE_CONTROL(UIView)

    CGRect frame = nativeControl.frame;
    frame.size.height = height;
    [nativeControl setFrame:frame];

    emit heightChanged();
}

bool QUIView::visible() const
{
    QMLUIKIT_NATIVE_CONTROL(UIView)
    return !(nativeControl.hidden);
}

void QUIView::setVisible(bool visible)
{
    if (visible == this->visible())
        return;

    QMLUIKIT_NATIVE_CONTROL(UIView)
    nativeControl.hidden = !visible;
    emit visibleChanged();
}

QColor QUIView::backgroundColor() const
{
    return m_backgroundColor;
}

void QUIView::setBackgroundColor(const QColor& color)
{
    m_backgroundColor = color;
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);

    QMLUIKIT_NATIVE_CONTROL(UIView)
    nativeControl.backgroundColor = uiColor;
    emit backgroundColorChanged();
}


