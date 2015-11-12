#include "quiwindow.h"

#include <UIKit/UIKit.h>

class QUIWindowPrivate {
public:
    UIScreen* m_screen;
    UIWindow* m_window;
};

QUIWindow::QUIWindow(QObject *parent)
    : QUIKitItem(parent),
      d(new QUIWindowPrivate)
{
    d->m_screen = [UIScreen mainScreen];
    d->m_window = [[UIWindow alloc] initWithFrame:[d->m_screen bounds]];

    d->m_window.screen = d->m_screen;
    d->m_window.backgroundColor = [UIColor whiteColor];

    [d->m_window makeKeyAndVisible];
}

QUIWindow::~QUIWindow()
{
}

QUIViewController* QUIWindow::initialViewController() const
{
    return m_initialViewController;
}

void QUIWindow::setInitialViewController(QUIViewController *controller)
{
    m_initialViewController = controller;
    d->m_window.rootViewController = (UIViewController*) controller->nativeItem();

    emit initialViewControllerChanged();
}
