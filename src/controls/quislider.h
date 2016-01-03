#ifndef QUISLIDER_H
#define QUISLIDER_H

#include "quicontrol.h"

class QUISliderPrivate;
class QUISlider : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)

public:
    QUISlider(QObject* parent = 0);
    ~QUISlider();

    qreal value() const;
    void setValue(qreal value);

signals:
    void valueChanged();

private:
    QUISliderPrivate* d;
};

#endif // QUISLIDER_H
