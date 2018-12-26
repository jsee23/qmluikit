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

#include "quiswitch.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISwitchEventHandler : NSObject
{
    @public
    QUISwitch *control;
}

- (IBAction) valueChanged : (id) sender;
@end

@implementation QUISwitchEventHandler
- (IBAction) valueChanged : (id) sender
{
    Q_UNUSED(sender)
    emit control->onChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

#include "quikithelpers.h"

class QUISwitchPrivate
{
public:
    QUISwitchEventHandler* native;
};

/*!
 * \brief TODO: doc
 * \qmltype UISwitch
 * \inqmlmodule jsee23.qmluikit
 *
 * \l {UISwitch} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUISwitch::QUISwitch(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISwitchPrivate)
{
    d->native = [[QUISwitchEventHandler alloc] init];
    m_nativeResource = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];

    QMLUIKIT_NATIVE_CONTROL(UISwitch)
    [nativeControl addTarget:d->native action:@selector(valueChanged:)
                   forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
}

QUISwitch::~QUISwitch()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UISwitch)
        [nativeControl release];
    }
}

bool QUISwitch::on() const
{
    QMLUIKIT_NATIVE_CONTROL(UISwitch)
    return nativeControl.on;
}

void QUISwitch::setOn(bool on)
{
    QMLUIKIT_NATIVE_CONTROL(UISwitch)
    [nativeControl setOn:on animated:TRUE];
}

QColor QUISwitch::onTintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).onTintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setOnTintColor(const QColor &color)
{
    QMLUIKIT_NATIVE_CONTROL(UISwitch)

    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    nativeControl.onTintColor = uiColor;

    emit onTintColorChanged();
}

QColor QUISwitch::thumbTintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).thumbTintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setThumbTintColor(const QColor &color)
{
    QMLUIKIT_NATIVE_CONTROL(UISwitch)

    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    nativeControl.thumbTintColor = uiColor;

    emit thumbTintColorChanged();
}

QColor QUISwitch::tintColor() const
{
#if 0
    UIColor* color = ((UISwitch*) m_nativeResource).tintColor;
    return QUIKitColors::uiColorToQColor(color);
#else
    return QColor();
#endif
}

void QUISwitch::setTintColor(const QColor &color)
{
    QMLUIKIT_NATIVE_CONTROL(UISwitch)

    UIColor* uiColor = QUIKitColors::qcolorToUIColor(color);
    nativeControl.tintColor = uiColor;

    emit tintColorChanged();
}

