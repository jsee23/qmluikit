#include "quilabel.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

static inline NSTextAlignment qNsTextAlignmentToNative(QUILabel::NSTextAlignment alignment)
{
    switch (alignment) {
    case QUILabel::NSTextAlignmentLeft:
        return NSTextAlignmentLeft;
    case QUILabel::NSTextAlignmentRight:
        return NSTextAlignmentRight;
    case QUILabel::NSTextAlignmentCenter:
        return NSTextAlignmentCenter;
    case QUILabel::NSTextAlignmentJustified:
        return NSTextAlignmentJustified;
    case QUILabel::NSTextAlignmentNatural:
        return NSTextAlignmentNatural;
    }
}

static inline QUILabel::NSTextAlignment qNsTextAlignmentToQt(NSTextAlignment alignment)
{
    switch (alignment) {
    case NSTextAlignmentLeft:
        return QUILabel::NSTextAlignmentLeft;
    case NSTextAlignmentRight:
        return QUILabel::NSTextAlignmentRight;
    case NSTextAlignmentCenter:
        return QUILabel::NSTextAlignmentCenter;
    case NSTextAlignmentJustified:
        return QUILabel::NSTextAlignmentJustified;
    case NSTextAlignmentNatural:
        return QUILabel::NSTextAlignmentNatural;
    }
}

QUILabel::QUILabel(QObject *parent)
    : QUIView(false, parent)
{
    m_nativeResource = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,20)];
}

QUILabel::~QUILabel()
{
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UILabel)
        [nativeControl release];
    }
}

QString QUILabel::text() const
{
    QMLUIKIT_NATIVE_CONTROL(UILabel)
    return QString::fromNSString(nativeControl.text);
}

void QUILabel::setText(const QString &text)
{
    QMLUIKIT_NATIVE_CONTROL(UILabel)
    if (text == this->text())
        return;

    nativeControl.text = text.toNSString();
    emit textChanged();
}

QUILabel::NSTextAlignment QUILabel::textAlignment() const
{
    QMLUIKIT_NATIVE_CONTROL(UILabel)
    return qNsTextAlignmentToQt(nativeControl.textAlignment);
}

void QUILabel::setTextAlignment(QUILabel::NSTextAlignment alignment)
{
    QMLUIKIT_NATIVE_CONTROL(UILabel)
    nativeControl.textAlignment = qNsTextAlignmentToNative(alignment);
}
