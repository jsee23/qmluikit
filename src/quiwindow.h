#ifndef QTNATIVEUI_H
#define QTNATIVEUI_H

#include <QObject>
#include <QColor>
#include <QtQml/QQmlListProperty>

#include "quikititem.h"
#include "quiviewcontroller.h"

class QUIWindowPrivate;

class QUIWindow : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor
               NOTIFY backgroundColorChanged)
    Q_PROPERTY(QUIViewController* initialViewController READ initialViewController
               WRITE setInitialViewController NOTIFY initialViewControllerChanged)

public:
    explicit QUIWindow(QObject *parent = 0);
    ~QUIWindow();

    QColor backgroundColor() const;
    void setBackgroundColor(const QColor& color);

    QUIViewController* initialViewController() const;
    void setInitialViewController(QUIViewController* controller);

signals:
    void backgroundColorChanged();
    void initialViewControllerChanged();

private:
    QUIWindowPrivate* d;
    QUIViewController* m_initialViewController;
};

#endif
