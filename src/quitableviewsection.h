#ifndef QUITABLEVIEWSECTION_H
#define QUITABLEVIEWSECTION_H

#include <QObject>

class QUITableViewSection : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title
               WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QStringList cells READ cells
               WRITE setCells NOTIFY cellsChanged)

public:
    QUITableViewSection(QObject *parent = 0);

    QString title() const;
    void setTitle(const QString &title);

    QStringList cells() const;
    void setCells(const QStringList cells);

signals:
    void titleChanged();
    void cellsChanged();

private:
    QString m_title;
    QStringList m_cells;
};

#endif // QUITABLEVIEWSECTION_H
