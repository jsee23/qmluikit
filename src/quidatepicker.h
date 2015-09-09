#ifndef QUIDATEPICKER_H
#define QUIDATEPICKER_H

#include <QDate>

#include <quicontrol.h>

class QUIDatePickerPrivate;
class QUIDatePicker : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(QDateTime date READ date NOTIFY dateChanged)

public:
    QUIDatePicker(QObject* parent = 0);
    ~QUIDatePicker();

    QDateTime date() const;

signals:
    void dateChanged();

private:
    QUIDatePickerPrivate* d;
};

#endif // QUIDATEPICKER_H
