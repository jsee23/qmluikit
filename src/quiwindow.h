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

#ifndef QTNATIVEUI_H
#define QTNATIVEUI_H

#include <QObject>
#include <QColor>
#include <QtQml/QQmlListProperty>

#include "views/quiview.h"
#include "controllers/quiviewcontroller.h"

class QUIWindowPrivate;

class QUIWindow : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(QUIViewController* initialViewController READ initialViewController
               WRITE setInitialViewController NOTIFY initialViewControllerChanged)

public:
    explicit QUIWindow(QObject *parent = 0);
    ~QUIWindow();

    QUIViewController* initialViewController() const;
    void setInitialViewController(QUIViewController* controller);

signals:
    void initialViewControllerChanged();

private:
    QUIWindowPrivate* d;
    QUIViewController* m_initialViewController;
};

#endif
