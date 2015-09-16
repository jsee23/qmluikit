#include "quiscrollview.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

QUIScrollView::QUIScrollView(QObject* parent)
    : QUIView(false, parent)
{
    m_nativeResource = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,100,20)];
}

QUIScrollView::~QUIScrollView()
{
}

int QUIScrollView::contentWidth() const
{
    return ((UIScrollView*) m_nativeResource).contentSize.width;
}

void QUIScrollView::setContentWidth(int width)
{
    ((UIScrollView*) m_nativeResource).contentSize =
            CGSizeMake(width, ((UIScrollView*) m_nativeResource).contentSize.height);
    emit contentWidthChanged();
}

int QUIScrollView::contentHeight() const
{
    return ((UIScrollView*) m_nativeResource).contentSize.height;
}

void QUIScrollView::setContentHeight(int height)
{
    ((UIScrollView*) m_nativeResource).contentSize =
            CGSizeMake(((UIScrollView*) m_nativeResource).contentSize.width, height);
    emit contentHeightChanged();
}
