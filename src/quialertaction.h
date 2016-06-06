#ifndef QUIALERTACTION_H
#define QUIALERTACTION_H

#include "quikititem.h"

class QUIAlertAction : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(Style style READ style WRITE setStyle NOTIFY styleChanged)

public:
    enum Style {
        DefaultStyle,
        CancelStyle,
        DestructiveStyle
    };
    Q_ENUM(Style)

    QUIAlertAction(QObject* parent = 0);
    ~QUIAlertAction();

    QString title() const;
    void setTitle(const QString &title);

    Style style() const;
    void setStyle(Style style);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

signals:
    void titleChanged();
    void styleChanged();

    void clicked();

private:
    void updateItem();

    QString m_title;
    Style m_style;
};

#endif // QUIALERTACTION_H
