#include "quitoolbar.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

//////////////////////////
// Qt
//////////////////////////

#include "quibarbuttonitem.h"

class QUIToolbarPrivate
{
public:
    NSMutableArray* items;
};

QUIToolbar::QUIToolbar(QObject* parent)
    : QUIView(false, parent),
      d(new QUIToolbarPrivate)
{
    m_nativeResource = [[UIToolbar alloc] init];
    ((UIToolbar*) m_nativeResource).frame = CGRectMake(0,0,100,20);
    d->items = [[NSMutableArray alloc] init];
}

QUIToolbar::~QUIToolbar()
{
    [((UIToolbar*) m_nativeResource) release];
    [d->items release];
}

void QUIToolbar::childrenDidChanged()
{
    // clearing array
    [d->items removeAllObjects];

    // appending children
    for (int i=0; i < m_children.size(); i++) {
        QUIBarButtonItem *view = qobject_cast<QUIBarButtonItem*>(m_children.at(i));
        if (view && view->nativeItem())
            [d->items addObject:((UIBarButtonItem*) view->nativeItem())];
    }

    // setting new array
    [((UIToolbar*) m_nativeResource) setItems:d->items animated:NO];
}
