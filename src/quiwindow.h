#ifndef QTNATIVEUI_H
#define QTNATIVEUI_H

#include <QObject>
#include <QColor>
#include <QtQml/QQmlListProperty>

#include "quiview.h"
#include "quiviewcontroller.h"

class QUIWindowPrivate;

class QUIWindow : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(QUIViewController* initialViewController READ initialViewController
               WRITE setInitialViewController NOTIFY initialViewControllerChanged)

public:
    explicit QUIWindow(QObject *parent = 0);
    ~QUIWindow();

    QUIViewController* initialViewController() const;
    void setInitialViewController(QUIViewController* controller);

signals:
    void initialViewControllerChanged();

private:
    QUIWindowPrivate* d;
    QUIViewController* m_initialViewController;
};

#endif
