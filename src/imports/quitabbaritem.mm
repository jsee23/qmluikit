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

#include <QImage>
#include <QFile>

#include "quitabbaritem.h"
#include "controllers/quiviewcontroller.h"
#include "quikithelpers.h"

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

UITabBarSystemItem systemItemToTag(QUITabBarItem::SystemItems item)
{
    switch (item) {
    case QUITabBarItem::More:
        return UITabBarSystemItemMore;
    case QUITabBarItem::Favorites:
        return UITabBarSystemItemFavorites;
    case QUITabBarItem::Featured:
        return UITabBarSystemItemFeatured;
    case QUITabBarItem::TopRated:
        return UITabBarSystemItemTopRated;
    case QUITabBarItem::Recents:
        return UITabBarSystemItemRecents;
    case QUITabBarItem::Contacts:
        return UITabBarSystemItemContacts;
    case QUITabBarItem::History:
        return UITabBarSystemItemHistory;
    case QUITabBarItem::Bookmarks:
        return UITabBarSystemItemBookmarks;
    case QUITabBarItem::Search:
        return UITabBarSystemItemSearch;
    case QUITabBarItem::Downloads:
        return UITabBarSystemItemDownloads;
    case QUITabBarItem::MostRecent:
        return UITabBarSystemItemMostRecent;
    case QUITabBarItem::MostViewed:
        return UITabBarSystemItemMostViewed;
    }
}

class QUITabBarItemPrivate
{
public:
    QUITabBarItemEventHandler* native;
    QString title;
    QUrl imageSource;
    QUITabBarItem::SystemItems systemItem;
    QUIViewController* targetViewController;
    bool componentCompleted;
};

QUITabBarItem::QUITabBarItem(QObject* parent)
    : QUIKitItem(parent)
    , d(new QUITabBarItemPrivate)
{
    d->native = [[QUITabBarItemEventHandler alloc] init];
    m_nativeResource = nullptr;
    d->native->control = this;
    d->systemItem = NoSystemItem;
    d->targetViewController = nullptr;
    d->componentCompleted = false;
}

QUITabBarItem::~QUITabBarItem()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UITabBarItem)
        [nativeControl release];
    }
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

QUrl QUITabBarItem::imageSource() const
{
    return d->imageSource;
}

void QUITabBarItem::setImageSource(const QUrl &source)
{
    if (source == d->imageSource)
        return;

    d->imageSource = source;
    emit imageSourceChanged();
}

QUITabBarItem::SystemItems QUITabBarItem::systemItem() const
{
    return d->systemItem;
}

void QUITabBarItem::setSystemItem(QUITabBarItem::SystemItems item)
{
    if (item == d->systemItem)
        return;

    d->systemItem = item;
    emit systemItemChanged();
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
    if (!d->imageSource.isEmpty()) {
        if (m_nativeResource) {
            QMLUIKIT_NATIVE_CONTROL(UITabBarItem)
            [nativeControl release];
        }

        // load file buffer
        QFile imgFile(d->imageSource.toString().remove("qrc"));
        imgFile.open(QFile::ReadOnly);
        NSData* rawImgData = imgFile.readAll().toNSData();
        imgFile.close();

        // create UIImage
        UIImage *img = [[UIImage alloc] initWithData:rawImgData];

        m_nativeResource = [[UITabBarItem alloc]
            initWithTitle:d->title.toNSString()
            image:img
            tag:0];

        updateViewControllerTarget();
    } else if (d->systemItem != NoSystemItem) {
        if (m_nativeResource) {
            QMLUIKIT_NATIVE_CONTROL(UITabBarItem)
            [nativeControl release];
        }

        m_nativeResource = [[UITabBarItem alloc]
                initWithTabBarSystemItem:systemItemToTag(d->systemItem)
                tag:0];

        updateViewControllerTarget();
    } else {
        if (m_nativeResource) {
            QMLUIKIT_NATIVE_CONTROL(UITabBarItem)
            [nativeControl release];
        }

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
        UITabBarItem* nativeItem = static_cast<UITabBarItem*>(this->nativeItem());
        UIViewController* controller = static_cast<UIViewController*>(d->targetViewController->nativeItem());
        [controller setTabBarItem:nativeItem];
    }
}
