#include "quitableviewsection.h"

QUITableViewSection::QUITableViewSection(QObject *parent)
    : QObject(parent)
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

QStringList QUITableViewSection::cells() const
{
    return m_cells;
}

void QUITableViewSection::setCells(const QStringList cells)
{
    if (cells == m_cells)
        return;

    m_cells = cells;
    emit cellsChanged();
}

