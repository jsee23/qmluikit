#ifndef QUIVIEW_H
#define QUIVIEW_H

#include <QColor>

#include "quikititem.h"

class QUIView : public QUIKitItem
{
    Q_OBJECT

    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibleChanged)

    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor
               NOTIFY backgroundColorChanged)

public:
    QUIView(QObject* parent = 0);
    QUIView(bool init, QObject* parent = 0);
    ~QUIView();

    int x() const;
    void setX(int x);

    int y() const;
    void setY(int y);

    int width() const;
    void setWidth(int width);

    int height() const;
    void setHeight(int height);

    bool visible() const;
    void setVisible(bool visible);

    QColor backgroundColor() const;
    void setBackgroundColor(const QColor& color);

    virtual void* nativeItem() Q_DECL_OVERRIDE;

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

signals:
    void xChanged();
    void yChanged();
    void widthChanged();
    void heightChanged();
    void visibleChanged();
    void backgroundColorChanged();

private:
    QColor m_backgroundColor;
};

#endif // QUIVIEW_H
