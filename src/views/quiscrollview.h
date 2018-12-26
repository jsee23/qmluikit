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

#ifndef QUISCROLLVIEW_H
#define QUISCROLLVIEW_H

#include "quiview.h"

class QUIScrollView : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(int contentWidth READ contentWidth
               WRITE setContentWidth NOTIFY contentWidthChanged)
    Q_PROPERTY(int contentHeight READ contentHeight
               WRITE setContentHeight NOTIFY contentHeightChanged)

public:
    QUIScrollView(QObject* parent = nullptr);
    ~QUIScrollView();

    int contentWidth() const;
    void setContentWidth(int width);

    int contentHeight() const;
    void setContentHeight(int height);

signals:
    void contentWidthChanged();
    void contentHeightChanged();
};

#endif // QUISCROLLVIEW_H
