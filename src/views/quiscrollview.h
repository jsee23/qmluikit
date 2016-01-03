#ifndef QUISCROLLVIEW_H
#define QUISCROLLVIEW_H

#include "quiview.h"

class QUIScrollView : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(int contentWidth READ contentWidth
               WRITE setContentWidth NOTIFY contentWidthChanged)
    Q_PROPERTY(int contentHeight READ contentHeight
               WRITE setContentHeight NOTIFY contentHeightChanged)

public:
    QUIScrollView(QObject* parent = 0);
    ~QUIScrollView();

    int contentWidth() const;
    void setContentWidth(int width);

    int contentHeight() const;
    void setContentHeight(int height);

signals:
    void contentWidthChanged();
    void contentHeightChanged();
};

#endif // QUISCROLLVIEW_H
