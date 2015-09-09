#include "quisegmentedcontrol.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISegmentedControlEventHandler : NSObject
{
    @public
    QUISegmentedControl *control;
}

- (void) currentIndexChanged : (UISegmentedControl*) segment;
@end

@implementation QUISegmentedControlEventHandler
- (void) currentIndexChanged : (UISegmentedControl*) segment
{
    emit control->selectedSegmentChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUISegmentedControlPrivate
{
public:
    QUISegmentedControlEventHandler* native;
    QStringList items;
};

QUISegmentedControl::QUISegmentedControl(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISegmentedControlPrivate)
{
    d->native = [[QUISegmentedControlEventHandler alloc] init];
    m_nativeResource = [[UISegmentedControl alloc] initWithItems:nil];
    [((UISegmentedControl*) m_nativeResource)
        addTarget:d->native
        action:@selector(currentIndexChanged:)
        forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUISegmentedControl::~QUISegmentedControl()
{
}

QStringList QUISegmentedControl::items() const
{
    return d->items;
}

void QUISegmentedControl::setItems(const QStringList &items)
{
    d->items = items;
    [((UISegmentedControl*) m_nativeResource) removeAllSegments];
    for (int i=0; i < items.size(); i++)
        [((UISegmentedControl*) m_nativeResource) insertSegmentWithTitle:items.at(i).toNSString()
            atIndex:i animated:FALSE];
}

int QUISegmentedControl::selectedSegment() const
{
    return ((UISegmentedControl*) m_nativeResource).selectedSegmentIndex;
}
