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

#ifndef QUISLIDER_H
#define QUISLIDER_H

#include "quicontrol.h"

#include <QtCore/QUrl>

class QUISliderPrivate;
class QUISlider : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(bool continuous READ continuous
               WRITE setContinuous NOTIFY continuousChanged)
    Q_PROPERTY(QUrl minimumValueImage READ minimumValueImage
               WRITE setMinimumValueImage NOTIFY minimumValueImageChanged)
    Q_PROPERTY(QUrl maximumValueImage READ maximumValueImage
               WRITE setMaximumValueImage NOTIFY maximumValueImageChanged)

public:
    QUISlider(QObject* parent = nullptr);
    ~QUISlider() override;

    qreal value() const;
    void setValue(qreal value);

    bool continuous() const;
    void setContinuous(bool continuous);

    QUrl minimumValueImage() const;
    void setMinimumValueImage(const QUrl &url);

    QUrl maximumValueImage() const;
    void setMaximumValueImage(const QUrl &url);

signals:
    void valueChanged();
    void continuousChanged();
    void minimumValueImageChanged();
    void maximumValueImageChanged();

private:
    QUISliderPrivate* d;
};

#endif // QUISLIDER_H
