/****************************************************************************
**
** Copyright (C) 2016 Jochen Seemann
**
** This file is part of the qmluikit library.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
****************************************************************************/

#include "quitabbaritem.h"
#include "controllers/quiviewcontroller.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUITabBarItemEventHandler : NSObject
{
    @public
    QUITabBarItem *control;
}

-(IBAction) clicked : (id) sender;
@end

@implementation QUITabBarItemEventHandler
- (IBAction) clicked : (id) sender
{
    emit control->clicked();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUITabBarItemPrivate
{
public:
    QUITabBarItemEventHandler* native;
    QString title;
    QUIViewController* targetViewController;
    bool componentCompleted;
};

QUITabBarItem::QUITabBarItem(QObject* parent)
    : QUIKitItem(parent)
    , d(new QUITabBarItemPrivate)
{
    d->native = [[QUITabBarItemEventHandler alloc] init];
    m_nativeResource = NULL;
    d->native->control = this;
    d->targetViewController = nullptr;
    d->componentCompleted = false;
}

QUITabBarItem::~QUITabBarItem()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource)
        [((UITabBarItem*) m_nativeResource) release];
}

QString QUITabBarItem::title() const
{
    return d->title;
}

void QUITabBarItem::setTitle(const QString &title)
{
    if (title == d->title)
        return;

    d->title = title;
    if (d->componentCompleted)
        updateItem();

    emit titleChanged();
}

void QUITabBarItem::setTargetViewController(QUIViewController *controller)
{
    d->targetViewController = controller;
    if (d->componentCompleted)
        updateViewControllerTarget();
}

void* QUITabBarItem::nativeItem()
{
    return m_nativeResource;
}

void QUITabBarItem::componentComplete()
{
    d->componentCompleted = true;
    updateItem();
}

void QUITabBarItem::updateItem()
{
    if (!title().isEmpty()) {
        if (m_nativeResource)
            [((UITabBarItem*) m_nativeResource) release];

        m_nativeResource = [[UITabBarItem alloc]
            initWithTitle:d->title.toNSString()
            image:nil
            tag:0];

        updateViewControllerTarget();
    }
}

void QUITabBarItem::updateViewControllerTarget()
{
    if (d->targetViewController && m_nativeResource) {
        UITabBarItem* nativeItem = (UITabBarItem*) this->nativeItem();
        [((UIViewController*) d->targetViewController->nativeItem())
                setTabBarItem:nativeItem];
    }
}
