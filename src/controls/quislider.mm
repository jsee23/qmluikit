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

#include "quislider.h"
#include "quikithelpers.h"

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QUISliderEventHandler : NSObject
{
    @public
    QUISlider *control;
}

-(IBAction) valueChanged : (id) sender;
@end

@implementation QUISliderEventHandler
- (IBAction) valueChanged : (id) sender
{
    Q_UNUSED(sender)
    emit control->valueChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

#include <QtCore/QUrl>

class QUISliderPrivate
{
public:
    QUISliderEventHandler* native;
    bool continuous;
    QUrl minimumValueImageSource;
    QUrl maximumValueImageSource;
};

/*!
 * \qmltype UISlider
 * \inqmlmodule jsee23.qmluikit
 * \instantiates QUISlider
 * \brief Used to select a value by sliding a handle along a track.
 *
 * \l {UISlider} is a TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // TODO: doc
 * \endqml
 */

QUISlider::QUISlider(QObject* parent)
    : QUIControl(false, parent),
      d(new QUISliderPrivate)
{
    d->native = [[QUISliderEventHandler alloc] init];
    m_nativeResource = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];

    QMLUIKIT_NATIVE_CONTROL(UISlider)
    [nativeControl addTarget:d->native action:@selector(valueChanged:)
                   forControlEvents:UIControlEventValueChanged];
    d->native->control = this;
    d->continuous = true;
}

QUISlider::~QUISlider()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UISlider)
        [nativeControl release];
    }
}

/*!
 * \qmlproperty real jsee23.qmluikit::UISlider::value
 *
 * This property holds the current value of the slider thumb. It is in the
 * range of the \l {minimumValue} and \l {maximumValue}.
 *
 * \sa minimumValue, maximumValue, continuous
 */
qreal QUISlider::value() const
{
    QMLUIKIT_NATIVE_CONTROL(UISlider)
    return nativeControl.value;
}

void QUISlider::setValue(qreal value)
{
    QMLUIKIT_NATIVE_CONTROL(UISlider)
    [nativeControl setValue:value animated:TRUE];
}

/*!
 * \qmlproperty bool jsee23.qmluikit::UISlider::continuous
 *
 * This property holds if the value changes of the user should be sent continuously
 * or not. If false, the value will just change when the user releases the thumb.
 * By default true.
 *
 * \sa value
 */
bool QUISlider::continuous() const
{
    return d->continuous;
}

void QUISlider::setContinuous(bool continuous)
{
    if (continuous == d->continuous)
        return;

    d->continuous = continuous;
    emit continuousChanged();

    //ToDo: ((UISlider*) m_nativeResource).isContinuous = continuous;
}

/*!
 * \qmlproperty real jsee23.qmluikit::UISlider::minimumValueImage
 *
 * This property holds the url to an image, that will be shown left to the
 * minimum of the slider.
 *
 * NOTE: currently not implemented!
 */
QUrl QUISlider::minimumValueImage() const
{
    return d->minimumValueImageSource;
}

void QUISlider::setMinimumValueImage(const QUrl &url)
{
    if (url == d->minimumValueImageSource)
        return;

    d->minimumValueImageSource = url;
    emit minimumValueImageChanged();

    qWarning("%s is not yet implemented...", __PRETTY_FUNCTION__);
}

/*!
 * \qmlproperty real jsee23.qmluikit::UISlider::maximumValueImage
 *
 * This property holds the url to an image, that will be shown right to the
 * maximum of the slider.
 *
 * NOTE: currently not implemented!
 */
QUrl QUISlider::maximumValueImage() const
{
    return d->maximumValueImageSource;
}

void QUISlider::setMaximumValueImage(const QUrl &url)
{
    if (url == d->maximumValueImageSource)
        return;

    d->maximumValueImageSource = url;
    emit maximumValueImageChanged();

    qWarning("%s is not yet implemented...", __PRETTY_FUNCTION__);
}
