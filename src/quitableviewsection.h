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
    Q_PROPERTY(QQmlListProperty<QUITableViewCell> cells READ cells
               NOTIFY cellsChanged)

public:
    QUITableViewSection(QObject *parent = 0);

    QString title() const;
    void setTitle(const QString &title);

    QQmlListProperty<QUITableViewCell> cells();
    int cellsCount() const;
    QUITableViewCell* cellItemAt(int index);

signals:
    void titleChanged();
    void cellsChanged();

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

private:
    QString m_title;
    QList<QUITableViewCell*> m_cells;
};

#endif // QUITABLEVIEWSECTION_H
