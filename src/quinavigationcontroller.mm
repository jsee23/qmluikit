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

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGSize size = self.view.frame.size;
    control->setSize(QSize(size.width, size.height));
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    emit control->navigationBarGeometryChanged();
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(statusFrameChanged:)
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];

    control->setStatusBarHeight(MIN([UIApplication sharedApplication].statusBarFrame.size.height,
                              [UIApplication sharedApplication].statusBarFrame.size.width));
}
- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]
        removeObserver:self
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];
    [super viewDidUnload];
}

- (void) statusFrameChanged:(NSNotification*)note
{
    CGRect statusBarFrame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    control->setStatusBarHeight(MIN(statusBarFrame.size.height,
                               statusBarFrame.size.width));
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
    [((UINavigationController*) m_nativeResource)
            pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];

    emit initialViewControllerChanged();
}

void QUINavigationController::pushViewController(QUIViewController* controller)
{
    controller->setSize(QSize(width(), height()));
    [((UINavigationController*) m_nativeResource)
            pushViewController:((UIViewController*) controller->nativeItem()) animated:YES];
//    // check navigation bar and its height
//    emit navigationBarGeometryChanged();
}

