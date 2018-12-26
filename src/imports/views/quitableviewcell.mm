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

#include "quitableviewcell.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

QUITableViewCell::QUITableViewCell(QObject *parent)
    : QUIView(false, parent)
    , m_style(StyleDefault)
    , m_componentCompleted(false)
{
    m_nativeResource = nullptr;
}

QUITableViewCell::~QUITableViewCell()
{
    QMLUIKIT_NATIVE_CONTROL(UITableViewCell)
    [nativeControl release];
    m_nativeResource = nullptr;
}

QString QUITableViewCell::textLabel() const
{
    return m_textLabel;
}

void QUITableViewCell::setTextLabel(const QString &title)
{
    if (m_textLabel == title)
        return;

    m_textLabel = title;
    emit textLabelChanged();

    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UITableViewCell)
        nativeControl.textLabel.text =  m_textLabel.toNSString();
    }
}

QString QUITableViewCell::detailTextLabel() const
{
    return m_detailTextLabel;
}

void QUITableViewCell::setDetailTextLabel(const QString &label)
{
    if (m_detailTextLabel == label)
        return;

    m_detailTextLabel = label;
    emit detailTextLabelChanged();

    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UITableViewCell)
        nativeControl.detailTextLabel.text =  m_detailTextLabel.toNSString();
    }
}

QUITableViewCell::CellStyle QUITableViewCell::style() const
{
    return m_style;
}

void QUITableViewCell::setStyle(QUITableViewCell::CellStyle style)
{
    if (style == m_style)
        return;

    m_style = style;
    emit styleChanged();

    if (m_componentCompleted)
        updateNativeItem();
}

void QUITableViewCell::componentComplete()
{
    m_componentCompleted = true;
    updateNativeItem();
}

void QUITableViewCell::updateNativeItem()
{
// *****************
// FIXME:   release the old UITableViewCell in a safe way....!
// *****************
//    if (m_nativeResource != nullptr)
//        [((UITableViewCell*) m_nativeResource) release];

    if (m_style == StyleDefault)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    else if (m_style == StyleValue1)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    else if (m_style == StyleValue2)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    else
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    QMLUIKIT_NATIVE_CONTROL(UITableViewCell)
    nativeControl.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    nativeControl.textLabel.text =  m_textLabel.toNSString();
    nativeControl.detailTextLabel.text =  m_detailTextLabel.toNSString();
}

