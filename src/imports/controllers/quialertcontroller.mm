/****************************************************************************
**
** Copyright (C) 2016 Jochen Seemann
**
** This file is part of the qmluikit library.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
****************************************************************************/

#include "quialertcontroller.h"
#include "../quialertaction.h"

#include <UIKit/UIKit.h>

static inline UIAlertControllerStyle styleToUIAlertControllerStyle(QUIAlertController::Style style)
{
    if (style == QUIAlertController::ActionSheetStyle)
        return UIAlertControllerStyleActionSheet;
    else
        return UIAlertControllerStyleAlert;
}

static inline UIAlertActionStyle styleToUIAlertActionStyle(QUIAlertAction::Style style)
{
    if (style == QUIAlertAction::DefaultStyle)
        return UIAlertActionStyleDefault;
    else if (style == QUIAlertAction::CancelStyle)
        return UIAlertActionStyleCancel;
    else
        return UIAlertActionStyleDestructive;
}

/*!
    \qmltype UIAlertController
    \inqmlmodule jsee23.qmluikit
    \brief Provides a popup \l {UIViewController}.

    \l {UIAlertController} is a TODO: doc

    \qml
    import jsee23.qmluikit 0.1

    // TODO: doc
    \endqml
*/

QUIAlertController::QUIAlertController(QObject *parent)
    : QUIViewController(false, parent)
    , m_style(QUIAlertController::ActionSheetStyle)
{
}

QUIAlertController::~QUIAlertController()
{
}

/*!
    \qmlproperty string jsee23.qmluikit::QUIAlertController::message

    TODO
 */
QString QUIAlertController::message() const
{
    return m_message;
}

void QUIAlertController::setMessage(const QString &msg)
{
    if (msg == m_message)
        return;

    m_message = msg;
    emit messageChanged();
}

/*!
    \qmlproperty jsee23.qmluikit::QUIAlertController::Style jsee23.qmluikit::QUIAlertController::style

    TODO
 */
QUIAlertController::Style QUIAlertController::style() const
{
    return m_style;
}

void QUIAlertController::setStyle(QUIAlertController::Style style)
{
    if (style == m_style)
        return;

    m_style = style;
    emit styleChanged();
}

void QUIAlertController::createControllerAndPresent(QUIViewController *parent)
{
    UIViewController* parentController = (UIViewController*) parent->nativeItem();

    NSString* controllerTitle = title().isEmpty() ? nil : title().toNSString();
    NSString* controllerMsg = m_message.isEmpty() ? nil : m_message.toNSString();
    UIAlertController* alert = [UIAlertController
            alertControllerWithTitle:controllerTitle
            message:controllerMsg
            preferredStyle:styleToUIAlertControllerStyle(m_style)];

    m_actions.clear();
    for (int i = 0; i < m_children.size(); i++) {
        QUIAlertAction* item = qobject_cast<QUIAlertAction*>(m_children.at(i));
        if (item) {
            UIAlertAction* action = [UIAlertAction
                        actionWithTitle:item->title().toNSString()
                        style:styleToUIAlertActionStyle(item->style())
                        handler:^(UIAlertAction * action) {
                            emit m_actions.at(i)->clicked();
                        }];
            [alert addAction:action];
            m_actions.append(item);
        }
    }

    [parentController presentViewController:alert animated:YES completion:nil];
}

void QUIAlertController::childrenDidChanged()
{
}
