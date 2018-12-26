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

#ifndef QUISWITCH_H
#define QUISWITCH_H

/*
  ToDo
  * could not get default color values
*/

#include <QColor>

#include "quicontrol.h"

class QUISwitchPrivate;
class QUISwitch : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(bool on READ on WRITE setOn NOTIFY onChanged)
    Q_PROPERTY(QColor onTintColor READ onTintColor
               WRITE setOnTintColor NOTIFY onTintColorChanged)
    Q_PROPERTY(QColor thumbTintColor READ thumbTintColor
               WRITE setThumbTintColor NOTIFY thumbTintColorChanged)
    Q_PROPERTY(QColor tintColor READ tintColor
               WRITE setTintColor NOTIFY tintColorChanged)

public:
    QUISwitch(QObject* parent = nullptr);
    ~QUISwitch() override;

    bool on() const;
    void setOn(bool on);

    QColor onTintColor() const;
    void setOnTintColor(const QColor &color);

    QColor thumbTintColor() const;
    void setThumbTintColor(const QColor &color);

    QColor tintColor() const;
    void setTintColor(const QColor &color);

signals:
    void onChanged();
    void onTintColorChanged();
    void thumbTintColorChanged();
    void tintColorChanged();

private:
    QUISwitchPrivate* d;
};

#endif // QUISWITCH_H
