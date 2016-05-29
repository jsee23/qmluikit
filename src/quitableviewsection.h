#ifndef QUITABLEVIEWSECTION_H
#define QUITABLEVIEWSECTION_H

#include <QQmlListProperty>

#include "quikititem.h"
#include "quitableviewcell.h"

class QUITableViewSection : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title
               WRITE setTitle NOTIFY titleChanged)

public:
    QUITableViewSection(QObject *parent = 0);

    QString title() const;
    void setTitle(const QString &title);

signals:
    void titleChanged();

private:
    QString m_title;
};

#endif // QUITABLEVIEWSECTION_H
