#include <UIKit/UIKit.h>
#include <QSize>

#include "quiviewcontroller.h"

//////////////////////////
// Objective-C
//////////////////////////

@interface QNative_UIViewController : UIViewController
{
    @public
    QUIViewController* control;
}
@end

@implementation QNative_UIViewController
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(size.width, size.height));
}

@end

//////////////////////////
// Qt
//////////////////////////

#include "quicontrol.h"

class QUIViewControllerPrivate
{
public:
    QSize m_size;
};

QUIViewController::QUIViewController(QObject *parent)
    : QUIKitItem(parent)
    , d(new QUIViewControllerPrivate)
{
    initNativeResource();
}

QUIViewController::QUIViewController(bool init, QObject *parent)
    : QUIKitItem(parent)
    , d(new QUIViewControllerPrivate)
{
    if (init)
        initNativeResource();
}

void QUIViewController::initNativeResource()
{
    m_nativeResource = [[QNative_UIViewController alloc] init];
    ((QNative_UIViewController*) m_nativeResource)->control = this;

    CGSize size = ((QNative_UIViewController*) m_nativeResource).view.frame.size;
    d->m_size = QSize(size.width, size.height);
}

QUIViewController::~QUIViewController()
{
    [((QNative_UIViewController*) m_nativeResource) release];
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
    return d->m_size.width();
}

int QUIViewController::height() const
{
    return d->m_size.height();
}

void QUIViewController::setSize(const QSize &size)
{
    if (size == d->m_size)
        return;

    d->m_size = size;
    emit widthChanged();
    emit heightChanged();
}

QRect QUIViewController::navigationBarGeometry() const
{
    if (!((UINavigationController*) m_nativeResource).navigationBar)
        return QRect();
    int x = ((UINavigationController*) m_nativeResource).navigationBar.frame.origin.x;
    int y = ((UINavigationController*) m_nativeResource).navigationBar.frame.origin.y;
    int width = ((UINavigationController*) m_nativeResource).navigationBar.frame.size.width;
    int height = ((UINavigationController*) m_nativeResource).navigationBar.frame.size.height;
    return QRect(x, y, width, height);
}

int QUIViewController::statusBarHeight() const
{
    return m_statusBarHeight;
}

void QUIViewController::setStatusBarHeight(int height)
{
    if (height == m_statusBarHeight)
        return;

    m_statusBarHeight = height;
    emit statusBarHeightChanged();
}
