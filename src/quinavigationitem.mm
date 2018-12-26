#include "quinavigationitem.h"

#include <UIKit/UIKit.h>

#include "quibarbuttonitem.h"
#include "quikithelpers.h"

/*!
 * \brief TODO: doc
 * \qmltype UINavigationItem
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UINavigationItem} is a class for manupulating the "navigation bar" of a
 * ViewController.
 *
 * The elements of a \l {UINavigationItem} are the left and right barButtonItems
 * and the prompt, a small text line showing more information in addition to the
 * title of the ViewController:
 *
 * TODO picture / screenshot
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * UIViewController {
 *     title: "My Controller"
 *
 *     navigationItem.leftBarButtonItem: UIBarButtonItem {
 *         title: "Add"
 *         onClicked: {
 *             // Do something...
 *         }
 *     }
 *     ...
 * }
 * \endqml
 */

QUINavigationItem::QUINavigationItem(void *item, QObject *parent)
    : QUIKitItem(parent)
{
    m_nativeResource = item;
}

/*!
 * \qmlproperty UIBarButtonItem jsee23.qmluikit::UINavigationItem::leftBarButtonItem
 *
 * TODO: doc
 */
QUIBarButtonItem *QUINavigationItem::leftBarButtonItem() const
{
    return m_leftBarButtonItem;
}

void QUINavigationItem::setLeftBarButtonItem(QUIBarButtonItem *item)
{
    if (item == m_leftBarButtonItem)
        return;

    m_leftBarButtonItem = item;
    emit leftBarButtonItemChanged();

    UIBarButtonItem* buttonItem = item ? static_cast<UIBarButtonItem*>(item->nativeItem()) : nullptr;
    QMLUIKIT_NATIVE_CONTROL(UINavigationItem)
    nativeControl.leftBarButtonItem = buttonItem;
}

/*!
 * \qmlproperty UIBarButtonItem jsee23.qmluikit::UINavigationItem::rightBarButtonItem
 *
 * TODO: doc
 */
QUIBarButtonItem *QUINavigationItem::rightBarButtonItem() const
{
    return m_rightBarButtonItem;
}

void QUINavigationItem::setRightBarButtonItem(QUIBarButtonItem *item)
{
    if (item == m_rightBarButtonItem)
        return;

    m_rightBarButtonItem = item;
    emit rightBarButtonItemChanged();

    QMLUIKIT_NATIVE_CONTROL(UINavigationItem)
    nativeControl.rightBarButtonItem = static_cast<UIBarButtonItem*>(item->nativeItem());
}

/*!
 * \qmlproperty string jsee23.qmluikit::UINavigationItem::prompt
 *
 * The prompt is a small text line horizontal centered on the UINavigationItem,
 * above the title of the ViewController.
 *
 * \sa {jsee23.qmluikit::UIViewController::title}
 */
QString QUINavigationItem::prompt() const
{
    return m_prompt;
}

void QUINavigationItem::setPrompt(const QString &prompt)
{
    if (prompt == m_prompt)
        return;

    m_prompt = prompt;
    emit promptChanged();

    QMLUIKIT_NATIVE_CONTROL(UINavigationItem)
    nativeControl.prompt = m_prompt.toNSString();
}

void *QUINavigationItem::nativeItem()
{
    return m_nativeResource;
}
