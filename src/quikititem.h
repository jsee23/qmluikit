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

#ifndef QUIKITITEM_H
#define QUIKITITEM_H

#include <QObject>
#include <QtQml/QQmlListProperty>

class QUIKitItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<QObject> children READ children NOTIFY childrenChanged)
    Q_CLASSINFO("DefaultProperty", "children")

public:
    explicit QUIKitItem(QObject *parent = nullptr);
    virtual ~QUIKitItem();

    QQmlListProperty<QObject> children();
    virtual void* nativeItem() {
        return nullptr;
    }

    static void append_child(QQmlListProperty<QObject> *list, QObject *child);
    static void clear_childPtr(QQmlListProperty<QObject> *property);
    static int child_Size(QQmlListProperty<QObject> *property);
    static QObject *child_At(QQmlListProperty<QObject> *property, int index);

protected slots:
    virtual void childrenDidChanged() {}

signals:
    void childrenChanged();

protected:
    QList<QObject *> m_children;
    void* m_nativeResource;
};

#endif // QUIKITITEM_H
