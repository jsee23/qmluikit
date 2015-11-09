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

QQmlListProperty<QUITableViewCell> QUITableViewSection::cells()
{
    return QQmlListProperty<QUITableViewCell>(this, m_cells);
}

int QUITableViewSection::cellsCount() const
{
    return m_cells.size();
}

QUITableViewCell *QUITableViewSection::cellItemAt(int index)
{
    if (index >= m_cells.size())
        return NULL;

    return m_cells.at(index);
}

void QUITableViewSection::childrenDidChanged()
{
    m_cells.clear();

    for (int i=0; i < m_children.size(); i++) {
        QUITableViewCell *cell = qobject_cast<QUITableViewCell*>(m_children.at(i));
        if (cell) {
            m_cells.append(cell);
            continue;
        }
    }
}
