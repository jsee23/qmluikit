#include "quibutton.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUIButtonEventHandler : NSObject
{
    @public
    QUIButton *button;
}

-(IBAction) clicked : (id) sender;
@end

@implementation QUIButtonEventHandler
- (IBAction) clicked : (id) sender
{
    emit button->clicked();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUIButtonPrivate
{
public:
    QUIButtonEventHandler* native;
};

QUIButton::QUIButton(QObject *parent)
    : QUIControl(false, parent),
      d(new QUIButtonPrivate)
{
    d->native = [[QUIButtonEventHandler alloc] init];
    m_nativeResource = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [((UIControl*) m_nativeResource) setFrame: CGRectMake(0, 0, 100, 40)];
    [((UIButton*) m_nativeResource) addTarget:d->native action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    d->native->button = this;
}

QUIButton::~QUIButton()
{
    if (d->native)
        [d->native release];
}

QString QUIButton::titleLabel() const
{
    return QString::fromNSString(((UIButton*) m_nativeResource).currentTitle);
}

void QUIButton::setTitleLabel(const QString &title)
{
    [((UIButton*) m_nativeResource) setTitle:title.toNSString() forState:UIControlStateNormal];
}
