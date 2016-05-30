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

#ifndef QUIVIEWCONTROLLER_H
#define QUIVIEWCONTROLLER_H

#include <QRect>

#include "quikititem.h"
#include "../quitabbaritem.h"

class QUIViewControllerPrivate;
class QUIViewController : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)
    Q_PROPERTY(QRect navigationBarGeometry READ navigationBarGeometry
               NOTIFY navigationBarGeometryChanged)
    Q_PROPERTY(int statusBarHeight READ statusBarHeight
               NOTIFY statusBarHeightChanged)

    Q_PROPERTY(QUITabBarItem* tabBarItem READ tabBarItem
               WRITE setTabBarItem NOTIFY tabBarItemChanged)

public:
    QUIViewController(QObject *parent = 0);
    QUIViewController(bool init, QObject *parent = 0);
    ~QUIViewController();

    QString title() const;
    void setTitle(const QString& title);

    int width() const;
    int height() const;
    void setSize(const QSize &size);

    QRect navigationBarGeometry() const;

    int statusBarHeight() const;
    void setStatusBarHeight(int height);

    QUITabBarItem* tabBarItem() const;
    void setTabBarItem(QUITabBarItem* item);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

signals:
    void titleChanged();
    void widthChanged();
    void heightChanged();
    void navigationBarGeometryChanged();
    void statusBarHeightChanged();
    void tabBarItemChanged();

private:
    void initNativeResource();
    QUIViewControllerPrivate* d;
    int m_statusBarHeight;
    QUITabBarItem* m_tabBarItem;
};

#endif // QUIVIEWCONTROLLER_H
