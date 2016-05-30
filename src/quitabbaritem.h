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

#ifndef QUITABBARITEM_H
#define QUITABBARITEM_H

#include <QtQml/QQmlParserStatus>

#include "quikititem.h"

class QUIViewController;
class QUITabBarItemPrivate;

class QUITabBarItem : public QUIKitItem, public QQmlParserStatus
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)

public:
    QUITabBarItem(QObject* parent = 0);
    ~QUITabBarItem();

    QString title() const;
    void setTitle(const QString &title);

    void setTargetViewController(QUIViewController* controller);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

protected:
    void classBegin() {}
    void componentComplete();

signals:
    void clicked();
    void titleChanged();

private:
    void updateItem();
    void updateViewControllerTarget();

    QUITabBarItemPrivate* d;
};

#endif // QUITABBARITEM_H
