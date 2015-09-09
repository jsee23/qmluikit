#include "quiprogressview.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

QUIProgressView::QUIProgressView(QObject* parent)
    : QUIView(false, parent)
{
    m_nativeResource = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    ((UIProgressView*) m_nativeResource).frame = CGRectMake(0,0,100,20);

    m_progressAnimated = true;
}

QUIProgressView::~QUIProgressView()
{
}

qreal QUIProgressView::progress() const
{
    return ((UIProgressView*) m_nativeResource).progress;
}

void QUIProgressView::setProgress(qreal progress)
{
    [((UIProgressView*) m_nativeResource) setProgress:progress animated:m_progressAnimated];
}

bool QUIProgressView::progressAnimated() const
{
    return m_progressAnimated;
}

void QUIProgressView::setProgressAnimated(bool animated)
{
    if (animated == m_progressAnimated)
        return;
    m_progressAnimated = animated;
    emit progressAnimatedChanged();
}

