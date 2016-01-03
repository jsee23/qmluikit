#ifndef QUICONTROL_H
#define QUICONTROL_H

#include "../views/quiview.h"

class QUIControl : public QUIView
{
    Q_OBJECT

public:
    QUIControl(QObject* parent = 0);
    QUIControl(bool init, QObject* parent = 0);
    ~QUIControl();
};

#endif // QUICONTROL_H
