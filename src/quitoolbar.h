#ifndef QUITOOLBAR_H
#define QUITOOLBAR_H

#include "views/quiview.h"

class QUIToolbarPrivate;
class QUIToolbar : public QUIView
{
    Q_OBJECT

public:
    QUIToolbar(QObject* parent = 0);
    ~QUIToolbar();

protected slots:
    virtual void childrenDidChanged() Q_DECL_OVERRIDE;

private:
    QUIToolbarPrivate* d;
};

#endif // QUITOOLBAR_H
