#include "quinavigationitem.h"

#include <UIKit/UIKit.h>

#include "quibarbuttonitem.h"

QUINavigationItem::QUINavigationItem(void *item, QObject *parent)
    : QUIKitItem(parent)
{
    m_nativeResource = item;
}

QUIBarButtonItem *QUINavigationItem::rightBarButtonItem() const
{
    return m_rightBarButtonItem;
}

void QUINavigationItem::setRightBarButtonItem(QUIBarButtonItem *item)
{
    if (item == m_rightBarButtonItem)
        return;

    m_rightBarButtonItem = item;
    emit rightBarButtonItemChanged();

    ((UINavigationItem*) m_nativeResource).rightBarButtonItem =
            (UIBarButtonItem*) item->nativeItem();
}

QString QUINavigationItem::prompt() const
{
    return m_prompt;
}

void QUINavigationItem::setPrompt(const QString &prompt)
{
    if (prompt == m_prompt)
        return;

    m_prompt = prompt;
    emit promptChanged();

    ((UINavigationItem*) m_nativeResource).prompt = m_prompt.toNSString();
}

void *QUINavigationItem::nativeItem()
{
    return m_nativeResource;
}