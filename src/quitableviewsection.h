#ifndef QUITABLEVIEWSECTION_H
#define QUITABLEVIEWSECTION_H

#include <QQmlListProperty>

#include "quikititem.h"
#include "quitableviewcell.h"

class QUITableViewSection : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)

public:
    QUITableViewSection(QObject *parent = 0);

    QString title() const;
    void setTitle(const QString &title);

    int count() const;
    void setCount(int count);

signals:
    void titleChanged();
    void countChanged();

private:
    QString m_title;
    int m_count;
};

#endif // QUITABLEVIEWSECTION_H
