#ifndef QUINAVIGATIONITEM_H
#define QUINAVIGATIONITEM_H

#include "quikititem.h"

class QUINavigationItem : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString prompt READ prompt WRITE setPrompt NOTIFY promptChanged)

public:
    QUINavigationItem(void* item, QObject *parent = 0);

    QString prompt() const;
    void setPrompt(const QString &prompt);

    virtual void* nativeItem() override;

signals:
    void promptChanged();

private:
    QString m_prompt;
};

#endif // QUINAVIGATIONITEM_H
