#ifndef QUIKITITEM_H
#define QUIKITITEM_H

#include <QObject>
#include <QtQml/QQmlListProperty>

class QUIKitItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<QObject> children READ children NOTIFY childrenChanged)
    Q_CLASSINFO("DefaultProperty", "children")

public:
    explicit QUIKitItem(QObject *parent = 0);
    ~QUIKitItem();

    QQmlListProperty<QObject> children();
    virtual void* nativeItem() {
        return NULL;
    }

    static void append_child(QQmlListProperty<QObject> *list, QObject *child);
    static void clear_childPtr(QQmlListProperty<QObject> *property);
    static int child_Size(QQmlListProperty<QObject> *property);
    static QObject *child_At(QQmlListProperty<QObject> *property, int index);

protected slots:
    virtual void childrenDidChanged() {}

signals:
    void childrenChanged();

protected:
    QList<QObject *> m_children;
    void* m_nativeResource;
};

#endif // QUIKITITEM_H
