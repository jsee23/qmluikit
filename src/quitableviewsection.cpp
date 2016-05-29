#include "quitableviewsection.h"

QUITableViewSection::QUITableViewSection(QObject *parent)
    : QUIKitItem(parent)
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
