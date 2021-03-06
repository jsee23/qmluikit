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

#ifndef QUIPROGRESSVIEW_H
#define QUIPROGRESSVIEW_H

/*
 ToDo
 * styles...?!
*/

#include "quiview.h"

class QUIProgressView : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(qreal progress READ progress WRITE setProgress NOTIFY progressChanged)
    Q_PROPERTY(bool progressAnimated READ progressAnimated WRITE setProgressAnimated NOTIFY progressAnimatedChanged)

public:
    QUIProgressView(QObject* parent = nullptr);
    ~QUIProgressView();

    qreal progress() const;
    void setProgress(qreal progress);

    bool progressAnimated() const;
    void setProgressAnimated(bool animated);

signals:
    void progressChanged();
    void progressAnimatedChanged();

private:
    bool m_progressAnimated;
};

#endif // QUIPROGRESSVIEW_H
