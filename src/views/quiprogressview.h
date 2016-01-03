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
    QUIProgressView(QObject* parent = 0);
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
