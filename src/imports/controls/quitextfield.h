#ifndef QUITEXTFIELD_H
#define QUITEXTFIELD_H

#include "quicontrol.h"

class QUITextFieldPrivate;
class QUITextField : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    QUITextField(QObject *parent = nullptr);
    ~QUITextField();

    QString text() const;
    void setText(const QString &text);

signals:
    void textChanged();

private:
    QUITextFieldPrivate* d;
};

#endif // QUITEXTFIELD_H
