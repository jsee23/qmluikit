#include "quitableviewcell.h"

#include <UIKit/UIKit.h>

QUITableViewCell::QUITableViewCell(QObject *parent)
    : QUIView(false, parent),
      m_style(StyleDefault)
{
    updateNativeItem();
}

QUITableViewCell::~QUITableViewCell()
{
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

    if (m_nativeResource != NULL)
        ((UITableViewCell*) m_nativeResource).textLabel.text =  m_textLabel.toNSString();
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

    if (m_nativeResource != NULL)
        ((UITableViewCell*) m_nativeResource).detailTextLabel.text =  m_detailTextLabel.toNSString();
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

    updateNativeItem();
}

void QUITableViewCell::updateNativeItem()
{
    if (m_nativeResource != NULL)
        [((UITableViewCell*) m_nativeResource) release];

    if (m_style == StyleDefault)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    else if (m_style == StyleValue1)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    else if (m_style == StyleValue2)
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    else
        m_nativeResource = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    ((UITableViewCell*) m_nativeResource).backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    ((UITableViewCell*) m_nativeResource).textLabel.text =  m_textLabel.toNSString();
    ((UITableViewCell*) m_nativeResource).detailTextLabel.text =  m_detailTextLabel.toNSString();
}

