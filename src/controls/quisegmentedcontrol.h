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

#ifndef QUISEGMENTEDCONTROL_H
#define QUISEGMENTEDCONTROL_H

#include "quicontrol.h"

class QUISegmentedControlPrivate;
class QUISegmentedControl : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(QStringList items READ items WRITE setItems NOTIFY itemsChanged)
    Q_PROPERTY(int selectedSegment READ selectedSegment NOTIFY selectedSegmentChanged)
    Q_PROPERTY(int initialSelectedSegment READ initialSelectedSegment
               WRITE setInitialSelectedSegment NOTIFY initialSelectedSegmentChanged)

public:
    QUISegmentedControl(QObject* parent = 0);
    ~QUISegmentedControl();

    QStringList items() const;
    void setItems(const QStringList &items);

    int selectedSegment() const;

    int initialSelectedSegment() const;
    void setInitialSelectedSegment(int index);

signals:
    void itemsChanged();
    void selectedSegmentChanged();
    void initialSelectedSegmentChanged();

private:
    QUISegmentedControlPrivate* d;
};

#endif // QUISEGMENTEDCONTROL_H
