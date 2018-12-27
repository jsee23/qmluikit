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

#ifndef QUIVIEW_H
#define QUIVIEW_H

#include <QColor>

#include "quikititem.h"

class QUIView : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibleChanged)

    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor
               NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor tintColor READ tintColor WRITE setTintColor NOTIFY tintColorChanged)

public:
    QUIView(QObject* parent = nullptr);
    QUIView(void* controllerRoot, QObject* parent);
    QUIView(bool init, QObject* parent = nullptr);
    ~QUIView() override;

    int x() const;
    void setX(int x);

    int y() const;
    void setY(int y);

    int width() const;
    void setWidth(int width);

    int height() const;
    void setHeight(int height);

    bool visible() const;
    void setVisible(bool visible);

    QColor backgroundColor() const;
    void setBackgroundColor(const QColor& color);

    QColor tintColor() const;
    void setTintColor(const QColor& color);

    virtual void* nativeItem() override;

protected slots:
    virtual void childrenDidChanged() override;

signals:
    void xChanged();
    void yChanged();
    void widthChanged();
    void heightChanged();
    void visibleChanged();
    void backgroundColorChanged();
    void tintColorChanged();

private:
    QColor m_backgroundColor;
};

#endif // QUIVIEW_H
