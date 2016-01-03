#ifndef QUISEGMENTEDCONTROL_H
#define QUISEGMENTEDCONTROL_H

#include "quicontrol.h"

class QUISegmentedControlPrivate;
class QUISegmentedControl : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(QStringList items READ items WRITE setItems NOTIFY itemsChanged)
    Q_PROPERTY(int selectedSegment READ selectedSegment NOTIFY selectedSegmentChanged)

public:
    QUISegmentedControl(QObject* parent = 0);
    ~QUISegmentedControl();

    QStringList items() const;
    void setItems(const QStringList &items);

    int selectedSegment() const;

signals:
    void itemsChanged();
    void selectedSegmentChanged();

private:
    QUISegmentedControlPrivate* d;
};

#endif // QUISEGMENTEDCONTROL_H
