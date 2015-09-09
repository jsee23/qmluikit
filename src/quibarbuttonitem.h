#ifndef QUIBARBUTTONITEM_H
#define QUIBARBUTTONITEM_H

#include "quikititem.h"

class QUIBarButtonItemPrivate;
class QUIBarButtonItem : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)

public:
    QUIBarButtonItem(QObject* parent = 0);
    ~QUIBarButtonItem();

    QString title() const;
    void setTitle(const QString &title);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

signals:
    void clicked();
    void titleChanged();

private:
    void updateItem();

    QUIBarButtonItemPrivate* d;
};

#endif // QUIBARBUTTONITEM_H
