#ifndef QUITABLEVIEWCONTROLLER_H
#define QUITABLEVIEWCONTROLLER_H

#include "quiviewcontroller.h"

#include "quitableviewsection.h"

class QUITableViewController : public QUIViewController
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<QUITableViewSection> sections READ sections
               NOTIFY sectionsChanged)

public:
    QUITableViewController(QObject* parent = 0);
    ~QUITableViewController();

    QQmlListProperty<QUITableViewSection> sections();
    QList<QUITableViewSection*> qlistSections() const;

signals:
    void sectionsChanged();

private:
    static void append_section(QQmlListProperty<QUITableViewSection> *list,
                               QUITableViewSection *slice);
    QList<QUITableViewSection*> m_sections;
};

#endif // QUITABLEVIEWCONTROLLER_H
