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

#ifndef QUIBUTTON_H
#define QUIBUTTON_H

/*
 ToDo
 * Hintergrundbilder
 * ...
*/

#include <QObject>
#include <QRect>

#include "quicontrol.h"

class QUIButtonPrivate;

class QUIButton : public QUIControl
{
    Q_OBJECT
    Q_PROPERTY(QString titleLabel READ titleLabel WRITE setTitleLabel NOTIFY titleLabelChanged)

public:
    QUIButton(QObject *parent = nullptr);
    ~QUIButton() override;

    QString titleLabel() const;
    void setTitleLabel(const QString& title);

signals:
    void titleLabelChanged();
    void clicked();

private:
    QUIButtonPrivate* d;
};

#endif // QUIBUTTON_H
