#ifndef QUINAVIGATIONCONTROLLER_H
#define QUINAVIGATIONCONTROLLER_H

#include "quiviewcontroller.h"

class QUINavigationController : public QUIViewController
{
    Q_OBJECT

    Q_PROPERTY(QUIViewController* initialViewController READ initialViewController
               WRITE setInitialViewController NOTIFY initialViewControllerChanged)

public:
    QUINavigationController(QObject* parent = 0);
    ~QUINavigationController();

    Q_INVOKABLE void pushViewController(QUIViewController*);

    QUIViewController* initialViewController() const;
    void setInitialViewController(QUIViewController* controller);

signals:
    void initialViewControllerChanged();

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

private:
    void initNativeResource();
    QUIViewController* m_initialViewController;
};

#endif // QUINAVIGATIONCONTROLLER_H
