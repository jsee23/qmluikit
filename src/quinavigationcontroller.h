#ifndef QUINAVIGATIONCONTROLLER_H
#define QUINAVIGATIONCONTROLLER_H

#include <QRect>

#include "quiviewcontroller.h"

class QUINavigationController : public QUIViewController
{
    Q_OBJECT

    Q_PROPERTY(QUIViewController* initialViewController READ initialViewController
               WRITE setInitialViewController NOTIFY initialViewControllerChanged)
    Q_PROPERTY(QRect navigationBarGeometry READ navigationBarGeometry
               NOTIFY navigationBarGeometryChanged)
    Q_PROPERTY(int statusBarHeight READ statusBarHeight
               NOTIFY statusBarHeightChanged)

public:
    QUINavigationController(QObject* parent = 0);
    ~QUINavigationController();

    Q_INVOKABLE void pushViewController(QUIViewController*);

    QUIViewController* initialViewController() const;
    void setInitialViewController(QUIViewController* controller);

    QRect navigationBarGeometry() const;

    int statusBarHeight() const;
    void setStatusBarHeight(int height);

signals:
    void initialViewControllerChanged();
    void navigationBarGeometryChanged();
    void statusBarHeightChanged();

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

private:
    void initNativeResource();
    QUIViewController* m_initialViewController;
    int m_statusBarHeight;
};

#endif // QUINAVIGATIONCONTROLLER_H
