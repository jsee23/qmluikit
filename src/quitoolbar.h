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

#ifndef QUITOOLBAR_H
#define QUITOOLBAR_H

#include "views/quiview.h"

class QUIToolbarPrivate;
class QUIToolbar : public QUIView
{
    Q_OBJECT

public:
    QUIToolbar(QObject* parent = 0);
    ~QUIToolbar();

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

private:
    QUIToolbarPrivate* d;
};

#endif // QUITOOLBAR_H
