/****************************************************************************
**
** Copyright (C) 2018 Jochen Seemann
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

#ifndef QUILABEL_H
#define QUILABEL_H

#include "quiview.h"

class QUILabel : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(NSTextAlignment textAlignment READ textAlignment WRITE setTextAlignment NOTIFY textAlignmentChanged)

public:
    enum NSTextAlignment {
        NSTextAlignmentLeft,
        NSTextAlignmentRight,
        NSTextAlignmentCenter,
        NSTextAlignmentJustified,
        NSTextAlignmentNatural
    };
    Q_ENUM(NSTextAlignment)

    QUILabel(QObject *parent = nullptr);
    ~QUILabel();

    QString text() const;
    void setText(const QString &text);

    NSTextAlignment textAlignment() const;
    void setTextAlignment(NSTextAlignment alignment);

signals:
    void textChanged();
    void textAlignmentChanged();
};

#endif // QUILABEL_H
