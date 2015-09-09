#include "quiwindow.h"

#include <UIKit/UIKit.h>

#include "quikithelpers.h"

class QUIWindowPrivate {
public:
    UIScreen* m_screen;
    UIWindow* m_window;

    QColor m_backgroundColor;
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

    d->m_backgroundColor = QColor::fromRgb(0,0,0);
}

QUIWindow::~QUIWindow()
{
}

QColor QUIWindow::backgroundColor() const
{
    return d->m_backgroundColor;
}

void QUIWindow::setBackgroundColor(const QColor& color)
{
    d->m_backgroundColor = color;
    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    d->m_window.backgroundColor = uiColor;
    emit backgroundColorChanged();
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
