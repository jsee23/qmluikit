#include "quibarbuttonitem.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUIBarButtonItemEventHandler : NSObject
{
    @public
    QUIBarButtonItem *control;
}

-(IBAction) clicked : (id) sender;
@end

@implementation QUIBarButtonItemEventHandler
- (IBAction) clicked : (id) sender
{
    emit control->clicked();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUIBarButtonItemPrivate
{
public:
    QUIBarButtonItemEventHandler* native;
    QString title;
};

QUIBarButtonItem::QUIBarButtonItem(QObject* parent)
    : QUIKitItem(parent),
      d(new QUIBarButtonItemPrivate)
{
    d->native = [[QUIBarButtonItemEventHandler alloc] init];
    m_nativeResource = NULL;
    d->native->control = this;
}

QUIBarButtonItem::~QUIBarButtonItem()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UIBarButtonItem*) m_nativeResource) release];
}

QString QUIBarButtonItem::title() const
{
    return d->title;
}

void QUIBarButtonItem::setTitle(const QString &title)
{
    if (title == d->title)
        return;
    d->title = title;
    updateItem();

    emit titleChanged();
}

void* QUIBarButtonItem::nativeItem()
{
    return m_nativeResource;
}

void QUIBarButtonItem::updateItem()
{
    // ToDo: Buttons with style="image"
    if (!title().isEmpty()) {
        if (m_nativeResource)
            [((UIBarButtonItem*) m_nativeResource) release];

        m_nativeResource = [[UIBarButtonItem alloc]
            initWithTitle:d->title.toNSString()
            style:UIBarButtonItemStylePlain
            target:d->native
            action:@selector(clicked:)];
    }
}
