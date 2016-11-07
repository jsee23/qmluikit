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

#include "quikititem.h"
#include <QDebug>

QUIKitItem::QUIKitItem(QObject *parent)
    : QObject(parent)
    , m_nativeResource(nullptr)
{
    connect(this, SIGNAL(childrenChanged()),
            this, SLOT(childrenDidChanged()));
}

QUIKitItem::~QUIKitItem()
{
}

QQmlListProperty<QObject> QUIKitItem::children()
{
    return QQmlListProperty<QObject>(this, 0, &QUIKitItem::append_child, &QUIKitItem::child_Size, &QUIKitItem::child_At, &QUIKitItem::clear_childPtr);
}

void QUIKitItem::append_child(QQmlListProperty<QObject> *list, QObject *child)
{
    QUIKitItem *ocitem = qobject_cast<QUIKitItem *>(list->object);
    if (child) {
        ocitem->m_children.append(child);
        emit ocitem->childrenChanged();
    }
}

QObject *QUIKitItem::child_At(QQmlListProperty<QObject> *property, int index)
{
    return static_cast< QList<QObject *> *>(property->data)->at(index);
}

int QUIKitItem::child_Size(QQmlListProperty<QObject> *property)
{
    return static_cast< QList<QObject *> *>(property->data)->size();
}

void QUIKitItem::clear_childPtr(QQmlListProperty<QObject> *property)
{
    QUIKitItem *ocitem = qobject_cast<QUIKitItem *>(property->object);
    if (ocitem)
        emit ocitem->childrenChanged();
    return static_cast< QList<QObject *> *>(property->data)->clear();
}
