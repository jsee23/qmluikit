#include "quialertaction.h"

QUIAlertAction::QUIAlertAction(QObject *parent)
    : QUIKitItem(parent)
    , m_style(QUIAlertAction::DefaultStyle)
{
    m_nativeResource = nullptr;
}

QUIAlertAction::~QUIAlertAction()
{
}

QString QUIAlertAction::title() const
{
    return m_title;
}

void QUIAlertAction::setTitle(const QString &title)
{
    if (title == m_title)
        return;

    m_title = title;
    emit titleChanged();
}

QUIAlertAction::Style QUIAlertAction::style() const
{
    return m_style;
}

void QUIAlertAction::setStyle(QUIAlertAction::Style style)
{
    if (style == m_style)
        return;

    m_style = style;
    emit styleChanged();
}

void* QUIAlertAction::nativeItem()
{
    return m_nativeResource;
}
