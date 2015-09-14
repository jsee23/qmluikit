#include "quinavigationcontroller.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QNative_UINavigationController : UINavigationController
{
    @public
    QUINavigationController* control;
}
@end

@implementation QNative_UINavigationController
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(size.width, size.height));
}
@end

//////////////////////////
// Qt
//////////////////////////

QUINavigationController::QUINavigationController(QObject* parent) :
    QUIViewController(false, parent)
{
    initNativeResource();
}

QUINavigationController::~QUINavigationController()
{
}

void QUINavigationController::initNativeResource()
{
    m_nativeResource = [[QNative_UINavigationController alloc] init];
    ((QNative_UINavigationController*) m_nativeResource)->control = this;
}

void QUINavigationController::childrenDidChanged()
{
}

QUIViewController* QUINavigationController::initialViewController() const
{
    return m_initialViewController;
}

void QUINavigationController::setInitialViewController(QUIViewController *controller)
{
    m_initialViewController = controller;
    pushViewController(controller);

    emit initialViewControllerChanged();
}

void QUINavigationController::pushViewController(QUIViewController* controller)
{
    controller->setSize(QSize(width(), height()));
    [((UINavigationController*) m_nativeResource)
            pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];

    // check navigation bar and its height
    emit navigationBarGeometryChanged();
}

QRect QUINavigationController::navigationBarGeometry() const
{
    if (!((UINavigationController*) m_nativeResource).navigationBar)
        return QRect();
    int x = ((UINavigationController*) m_nativeResource).navigationBar.frame.origin.x;
    int y = ((UINavigationController*) m_nativeResource).navigationBar.frame.origin.y;
    int width = ((UINavigationController*) m_nativeResource).navigationBar.frame.size.width;
    int height = ((UINavigationController*) m_nativeResource).navigationBar.frame.size.height;
    return QRect(x, y, width, height);
}

