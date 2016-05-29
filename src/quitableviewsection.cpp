#include "quitableviewsection.h"

QUITableViewSection::QUITableViewSection(QObject *parent)
    : QUIKitItem(parent)
    , m_count(0)
{
}

QString QUITableViewSection::title() const
{
    return m_title;
}

void QUITableViewSection::setTitle(const QString &title)
{
    if (title == m_title)
        return;

    m_title = title;
    emit titleChanged();
}

int QUITableViewSection::count() const
{
    return m_count;
}

void QUITableViewSection::setCount(int count)
{
    if (count == m_count)
        return;

    m_count = count;
    emit countChanged();
}
