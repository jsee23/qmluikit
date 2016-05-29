#include "quiswitch.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISwitchEventHandler : NSObject
{
    @public
    QUISwitch *control;
}

- (IBAction) valueChanged : (id) sender;
@end

@implementation QUISwitchEventHandler
- (IBAction) valueChanged : (id) sender
{
    emit control->onChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

#include "quikithelpers.h"

class QUISwitchPrivate
{
public:
    QUISwitchEventHandler* native;
};

QUISwitch::QUISwitch(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISwitchPrivate)
{
    d->native = [[QUISwitchEventHandler alloc] init];
    m_nativeResource = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [((UISwitch*) m_nativeResource)
        addTarget:d->native
        action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUISwitch::~QUISwitch()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UISwitch*) m_nativeResource) release];
}

bool QUISwitch::on() const
{
    return ((UISwitch*) m_nativeResource).on;
}

void QUISwitch::setOn(bool on)
{
    [((UISwitch*) m_nativeResource) setOn:on animated:TRUE];
}

QColor QUISwitch::onTintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).onTintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setOnTintColor(const QColor &color)
{
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    ((UISwitch*) m_nativeResource).onTintColor = uiColor;

    emit onTintColorChanged();
}

QColor QUISwitch::thumbTintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).thumbTintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setThumbTintColor(const QColor &color)
{
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    ((UISwitch*) m_nativeResource).thumbTintColor = uiColor;

    emit thumbTintColorChanged();
}

QColor QUISwitch::tintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).tintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setTintColor(const QColor &color)
{
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    ((UISwitch*) m_nativeResource).tintColor = uiColor;

    emit tintColorChanged();
}
