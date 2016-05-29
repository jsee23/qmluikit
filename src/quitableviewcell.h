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

#ifndef QUITABLEVIEWCELL_H
#define QUITABLEVIEWCELL_H

#include <QtQml/QQmlParserStatus>

#include "views/quiview.h"

class QUITableViewCell : public QUIView, public QQmlParserStatus
{
    Q_OBJECT

    Q_PROPERTY(QString textLabel READ textLabel
               WRITE setTextLabel NOTIFY textLabelChanged)
    Q_PROPERTY(QString detailTextLabel READ detailTextLabel
               WRITE setDetailTextLabel NOTIFY detailTextLabelChanged)
    Q_PROPERTY(CellStyle style READ style
               WRITE setStyle NOTIFY styleChanged)

    Q_INTERFACES(QQmlParserStatus)

public:
    enum CellStyle
    {
        StyleDefault,
        StyleValue1,
        StyleValue2,
        StyleSubtitle
    };
    Q_ENUMS(CellStyle)

    QUITableViewCell(QObject *parent = 0);
    ~QUITableViewCell();

    QString textLabel() const;
    void setTextLabel(const QString &textLabel);

    QString detailTextLabel() const;
    void setDetailTextLabel(const QString &label);

    CellStyle style() const;
    void setStyle(CellStyle style);

protected:
    void classBegin() {}
    void componentComplete();

signals:
    void textLabelChanged();
    void detailTextLabelChanged();
    void styleChanged();

    void selected();

private:
    void updateNativeItem();

    QString m_textLabel;
    QString m_detailTextLabel;
    CellStyle m_style;

    bool m_componentCompleted;
};

#endif // QUITABLEVIEWCELL_H
