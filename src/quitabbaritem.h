#ifndef QUITABBARITEM_H
#define QUITABBARITEM_H

#include "quikititem.h"

class QUIViewController;
class QUITabBarItemPrivate;
class QUITabBarItem : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)

public:
    QUITabBarItem(QObject* parent = 0);
    ~QUITabBarItem();

    QString title() const;
    void setTitle(const QString &title);

    void setTargetViewController(QUIViewController* controller);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

signals:
    void clicked();
    void titleChanged();

private:
    void updateItem();

    QUITabBarItemPrivate* d;
    QUIViewController* m_targetViewController;
};

#endif // QUITABBARITEM_H
