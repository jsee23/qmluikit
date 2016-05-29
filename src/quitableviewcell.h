#ifndef QUITABLEVIEWCELL_H
#define QUITABLEVIEWCELL_H

#include <QtQml/QQmlParserStatus>

#include "views/quiview.h"

class QUITableViewCell : public QUIView, public QQmlParserStatus
{
    Q_OBJECT

    Q_PROPERTY(QString textLabel READ textLabel
               WRITE setTextLabel NOTIFY textLabelChanged)
    Q_PROPERTY(QString detailTextLabel READ detailTextLabel
               WRITE setDetailTextLabel NOTIFY detailTextLabelChanged)
    Q_PROPERTY(CellStyle style READ style
               WRITE setStyle NOTIFY styleChanged)

    Q_INTERFACES(QQmlParserStatus)

public:
    enum CellStyle
    {
        StyleDefault,
        StyleValue1,
        StyleValue2,
        StyleSubtitle
    };
    Q_ENUMS(CellStyle)

    QUITableViewCell(QObject *parent = 0);
    ~QUITableViewCell();

    QString textLabel() const;
    void setTextLabel(const QString &textLabel);

    QString detailTextLabel() const;
    void setDetailTextLabel(const QString &label);

    CellStyle style() const;
    void setStyle(CellStyle style);

protected:
    void classBegin() {}
    void componentComplete();

signals:
    void textLabelChanged();
    void detailTextLabelChanged();
    void styleChanged();

    void selected();

private:
    void updateNativeItem();

    QString m_textLabel;
    QString m_detailTextLabel;
    CellStyle m_style;

    bool m_componentCompleted;
};

#endif // QUITABLEVIEWCELL_H
