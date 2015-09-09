#include "quiviewcontroller.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QNative_UIViewController : UIViewController
{
    @public
    QUIViewController* control;
}
@end

@implementation QNative_UIViewController
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(size.width, size.height));
    emit control->widthChanged();
    emit control->heightChanged();
}

@end

//////////////////////////
// Qt
//////////////////////////

#include "quicontrol.h"

QUIViewController::QUIViewController(QObject *parent) :
    QUIKitItem(parent)
{
    initNativeResource();
}

QUIViewController::QUIViewController(bool init, QObject *parent) :
    QUIKitItem(parent)
{
    if (init)
        initNativeResource();
}

void QUIViewController::initNativeResource()
{
    m_nativeResource = [[QNative_UIViewController alloc] init];
    ((QNative_UIViewController*) m_nativeResource)->control = this;

    CGSize size = ((QNative_UIViewController*) m_nativeResource).view.frame.size;
    m_size = QSize(size.width, size.height);
}

QUIViewController::~QUIViewController()
{
}

void* QUIViewController::nativeItem()
{
    return m_nativeResource;
}

void QUIViewController::childrenDidChanged()
{
    for (int i=0; i < m_children.size(); i++) {
        QUIView *view = qobject_cast<QUIView*>(m_children.at(i));
        if (view && view->nativeItem()) {
            [((UIViewController*) m_nativeResource).view addSubview:(UIView*)view->nativeItem()];
            continue;
        }
    }
}

QString QUIViewController::title() const
{
    return QString::fromNSString(((UIViewController*) m_nativeResource).navigationItem.title);
}

void QUIViewController::setTitle(const QString &title)
{
    [((UIViewController*) m_nativeResource).navigationItem
            setTitle:title.toNSString()];

    emit titleChanged();
}

int QUIViewController::width() const
{
    return m_size.width();
}

int QUIViewController::height() const
{
    return m_size.height();
}

void QUIViewController::setSize(const QSize &size)
{
    m_size = size;
}
