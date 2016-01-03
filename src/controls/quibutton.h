#ifndef QUIBUTTON_H
#define QUIBUTTON_H

/*
 ToDo
 * Hintergrundbilder
 * ...
*/

#include <QObject>
#include <QRect>

#include "quicontrol.h"

class QUIButtonPrivate;

class QUIButton : public QUIControl
{
    Q_OBJECT
    Q_PROPERTY(QString titleLabel READ titleLabel WRITE setTitleLabel NOTIFY titleLabelChanged)

public:
    QUIButton(QObject *parent = 0);
    ~QUIButton();

    QString titleLabel() const;
    void setTitleLabel(const QString& title);

signals:
    void titleLabelChanged();
    void clicked();

private:
    QUIButtonPrivate* d;
};

#endif // QUIBUTTON_H
