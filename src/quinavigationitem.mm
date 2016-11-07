#include "quinavigationitem.h"

#include <UIKit/UIKit.h>

QUINavigationItem::QUINavigationItem(void *item, QObject *parent)
    : QUIKitItem(parent)
{
    m_nativeResource = item;
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
