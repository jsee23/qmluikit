#ifndef QUIVIEWCONTROLLER_H
#define QUIVIEWCONTROLLER_H

#include <QSize>

#include "quikititem.h"

class QUIViewController : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)

public:
    QUIViewController(QObject *parent = 0);
    QUIViewController(bool init, QObject *parent = 0);
    ~QUIViewController();

    QString title() const;
    void setTitle(const QString& title);

    int width() const;
    int height() const;
    void setSize(const QSize &size);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

signals:
    void titleChanged();
    void widthChanged();
    void heightChanged();

private:
    void initNativeResource();
    QSize m_size;
};

#endif // QUIVIEWCONTROLLER_H
