#ifndef QUITABLEVIEWCELL_H
#define QUITABLEVIEWCELL_H

#include "quiview.h"

class QUITableViewCell : public QUIView
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title
               WRITE setTitle NOTIFY titleChanged)

public:
    QUITableViewCell(QObject *parent = 0);
    ~QUITableViewCell();

    QString title() const;
    void setTitle(const QString &title);

signals:
    void titleChanged();
    void selected();

private:
    void updateNativeItem();

    QString m_title;
};

#endif // QUITABLEVIEWCELL_H
