#include "quikititem.h"
#include <QDebug>

QUIKitItem::QUIKitItem(QObject *parent) : QObject(parent)
{
    connect(this, SIGNAL(childrenChanged()),
            this, SLOT(childrenDidChanged()));
}

QUIKitItem::~QUIKitItem()
{
}

QQmlListProperty<QObject> QUIKitItem::children()
{
    return QQmlListProperty<QObject>(this, 0, &QUIKitItem::append_child, &QUIKitItem::child_Size, &QUIKitItem::child_At, &QUIKitItem::clear_childPtr);
}

void QUIKitItem::append_child(QQmlListProperty<QObject> *list, QObject *child)
{
    QUIKitItem *ocitem = qobject_cast<QUIKitItem *>(list->object);
    if (child) {
        ocitem->m_children.append(child);
        emit ocitem->childrenChanged();
    }
}

QObject *QUIKitItem::child_At(QQmlListProperty<QObject> *property, int index)
{
    return static_cast< QList<QObject *> *>(property->data)->at(index);
}

int QUIKitItem::child_Size(QQmlListProperty<QObject> *property)
{
    return static_cast< QList<QObject *> *>(property->data)->size();
}

void QUIKitItem::clear_childPtr(QQmlListProperty<QObject> *property)
{
    QUIKitItem *ocitem = qobject_cast<QUIKitItem *>(property->object);
    if (ocitem)
        emit ocitem->childrenChanged();
    return static_cast< QList<QObject *> *>(property->data)->clear();
}
