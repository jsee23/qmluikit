#include "quiview.h"

#include <UIKit/UIKit.h>

#include "quikithelpers.h"

QUIView::QUIView(QObject* parent) :
    QUIKitItem(parent)
{
    m_nativeResource = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    m_backgroundColor = QColor::fromRgb(0,0,0);
}

QUIView::QUIView(bool init, QObject *parent) :
    QUIKitItem(parent)
{
    if (init)
        m_nativeResource = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIView::~QUIView()
{
}

void* QUIView::nativeItem()
{
    return m_nativeResource;
}

void QUIView::childrenDidChanged()
{
    for (int i=0; i < m_children.size(); i++) {
        QUIView *view = qobject_cast<QUIView*>(m_children.at(i));
        if (view && view->nativeItem()) {
            [((UIView*) m_nativeResource) addSubview:(UIView*)view->nativeItem()];
            continue;
        }
    }
}

int QUIView::x() const
{
    return ((UIControl*) m_nativeResource).frame.origin.x;
}

void QUIView::setX(int x)
{
    CGRect frame = ((UIControl*) m_nativeResource).frame;
    frame.origin.x = x;
    [((UIControl*) m_nativeResource) setFrame:frame];

    emit xChanged();
}

int QUIView::y() const
{
    return ((UIControl*) m_nativeResource).frame.origin.y;
}

void QUIView::setY(int y)
{
    CGRect frame = ((UIControl*) m_nativeResource).frame;
    frame.origin.y = y;
    [((UIControl*) m_nativeResource) setFrame:frame];

    emit yChanged();
}

int QUIView::width() const
{
    return ((UIControl*) m_nativeResource).frame.size.width;
}

void QUIView::setWidth(int width)
{
    CGRect frame = ((UIControl*) m_nativeResource).frame;
    frame.size.width = width;
    [((UIControl*) m_nativeResource) setFrame:frame];

    emit widthChanged();
}

int QUIView::height() const
{
    return ((UIControl*) m_nativeResource).frame.size.height;
}

void QUIView::setHeight(int height)
{
    CGRect frame = ((UIControl*) m_nativeResource).frame;
    frame.size.height = height;
    [((UIControl*) m_nativeResource) setFrame:frame];

    emit heightChanged();
}

bool QUIView::visible() const
{
    return !(((UIView*) m_nativeResource).hidden);
}

void QUIView::setVisible(bool visible)
{
    if (visible == this->visible())
        return;
    ((UIView*) m_nativeResource).hidden = !visible;
    emit visibleChanged();
}

QColor QUIView::backgroundColor() const
{
    return m_backgroundColor;
}

void QUIView::setBackgroundColor(const QColor& color)
{
    m_backgroundColor = color;
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    ((UIView*) m_nativeResource).backgroundColor = uiColor;
    emit backgroundColorChanged();
}


