#ifndef QUINAVIGATIONITEM_H
#define QUINAVIGATIONITEM_H

#include "quikititem.h"

class QUIBarButtonItem;

class QUINavigationItem : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QUIBarButtonItem* rightBarButtonItem READ rightBarButtonItem
               WRITE setRightBarButtonItem NOTIFY rightBarButtonItemChanged)

    Q_PROPERTY(QString prompt READ prompt WRITE setPrompt NOTIFY promptChanged)

public:
    QUINavigationItem(void* item, QObject *parent = 0);

    QUIBarButtonItem* rightBarButtonItem() const;
    void setRightBarButtonItem(QUIBarButtonItem* item);

    QString prompt() const;
    void setPrompt(const QString &prompt);

    virtual void* nativeItem() override;

signals:
    void promptChanged();
    void rightBarButtonItemChanged();

private:
    QString m_prompt;
    QUIBarButtonItem* m_rightBarButtonItem;
};

#endif // QUINAVIGATIONITEM_H