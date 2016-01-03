#include "quidatepicker.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUIDatePickerEventHandler : NSObject
{
    @public
    QUIDatePicker *control;
}
@end

@implementation QUIDatePickerEventHandler
- (IBAction) valueChanged : (id) sender
{
    emit control->dateChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUIDatePickerPrivate
{
public:
    QUIDatePickerEventHandler* native;
};

QUIDatePicker::QUIDatePicker(QObject* parent)
    : QUIControl(false, parent),
      d(new QUIDatePickerPrivate)
{
    d->native = [[QUIDatePickerEventHandler alloc] init];
    m_nativeResource = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [((UIDatePicker*) m_nativeResource)
        addTarget:d->native
        action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUIDatePicker::~QUIDatePicker()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UIDatePicker*) m_nativeResource) release];
}

QDateTime QUIDatePicker::date() const
{
    // ToDo!!!
    return QDateTime();
}
