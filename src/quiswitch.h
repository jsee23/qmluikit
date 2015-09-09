#ifndef QUISWITCH_H
#define QUISWITCH_H

/*
  ToDo
  * could not get default color values
*/

#include <QColor>

#include <quicontrol.h>

class QUISwitchPrivate;
class QUISwitch : public QUIControl
{
    Q_OBJECT

    Q_PROPERTY(bool on READ on WRITE setOn NOTIFY onChanged)
    Q_PROPERTY(QColor onTintColor READ onTintColor
               WRITE setOnTintColor NOTIFY onTintColorChanged)
    Q_PROPERTY(QColor thumbTintColor READ thumbTintColor
               WRITE setThumbTintColor NOTIFY thumbTintColorChanged)
    Q_PROPERTY(QColor tintColor READ tintColor
               WRITE setTintColor NOTIFY tintColorChanged)

public:
    QUISwitch(QObject* parent = 0);
    ~QUISwitch();

    bool on() const;
    void setOn(bool on);

    QColor onTintColor() const;
    void setOnTintColor(const QColor &color);

    QColor thumbTintColor() const;
    void setThumbTintColor(const QColor &color);

    QColor tintColor() const;
    void setTintColor(const QColor &color);

signals:
    void onChanged();
    void onTintColorChanged();
    void thumbTintColorChanged();
    void tintColorChanged();

private:
    QUISwitchPrivate* d;
};

#endif // QUISWITCH_H
