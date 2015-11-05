#ifndef QUIVIEWCONTROLLER_H
#define QUIVIEWCONTROLLER_H

#include <QRect>

#include "quikititem.h"

class QUIViewControllerPrivate;
class QUIViewController : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)
    Q_PROPERTY(QRect navigationBarGeometry READ navigationBarGeometry
               NOTIFY navigationBarGeometryChanged)
    Q_PROPERTY(int statusBarHeight READ statusBarHeight
               NOTIFY statusBarHeightChanged)

public:
    QUIViewController(QObject *parent = 0);
    QUIViewController(bool init, QObject *parent = 0);
    ~QUIViewController();

    QString title() const;
    void setTitle(const QString& title);

    int width() const;
    int height() const;
    void setSize(const QSize &size);

    QRect navigationBarGeometry() const;

    int statusBarHeight() const;
    void setStatusBarHeight(int height);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

signals:
    void titleChanged();
    void widthChanged();
    void heightChanged();
    void navigationBarGeometryChanged();
    void statusBarHeightChanged();

private:
    void initNativeResource();
    QUIViewControllerPrivate* d;
    int m_statusBarHeight;
};

#endif // QUIVIEWCONTROLLER_H
