#include "quislider.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISliderEventHandler : NSObject
{
    @public
    QUISlider *control;
}

-(IBAction) valueChanged : (id) sender;
@end

@implementation QUISliderEventHandler
- (IBAction) valueChanged : (id) sender
{
    emit control->valueChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUISliderPrivate
{
public:
    QUISliderEventHandler* native;
};

QUISlider::QUISlider(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISliderPrivate)
{
    d->native = [[QUISliderEventHandler alloc] init];
    m_nativeResource = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [((UISlider*) m_nativeResource)
        addTarget:d->native
        action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUISlider::~QUISlider()
{
}

qreal QUISlider::value() const
{
    return ((UISlider*) m_nativeResource).value;
}

void QUISlider::setValue(qreal value)
{
    [((UISlider*) m_nativeResource) setValue:value animated:TRUE];
}
