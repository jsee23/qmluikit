#include "quicontrol.h"

#include <UIKit/UIKit.h>

QUIControl::QUIControl(QObject* parent) :
    QUIView(false, parent)
{
    m_nativeResource = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIControl::QUIControl(bool init, QObject *parent) :
    QUIView(false, parent)
{
    if (init)
        m_nativeResource = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

QUIControl::~QUIControl()
{
    if (m_nativeResource)
        [((UIControl*) m_nativeResource) release];
}
