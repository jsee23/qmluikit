#include "quitableviewcell.h"

#include <UIKit/UIKit.h>

QUITableViewCell::QUITableViewCell(QObject *parent) : QUIView(false, parent)
{
}

QUITableViewCell::~QUITableViewCell()
{
}

QString QUITableViewCell::title() const
{
    return m_title;
}

void QUITableViewCell::setTitle(const QString &title)
{
    if (m_title == title)
        return;

    m_title = title;
    emit titleChanged();

    updateNativeItem();
}

void QUITableViewCell::updateNativeItem()
{
    if (m_title.isEmpty())
        return;

    m_nativeResource = [[UITableViewCell alloc] init];
    ((UITableViewCell*) m_nativeResource).backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    ((UITableViewCell*) m_nativeResource).textLabel.text =  m_title.toNSString();
}

