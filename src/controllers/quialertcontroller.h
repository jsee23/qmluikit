#ifndef QUIALERTCONTROLLER_H
#define QUIALERTCONTROLLER_H

#include "quiviewcontroller.h"
#include "../quialertaction.h"

class QUIAlertController : public QUIViewController
{
    Q_OBJECT

    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
    Q_PROPERTY(Style style READ style WRITE setStyle NOTIFY styleChanged)

public:
    enum Style {
        ActionSheetStyle,
        AlertStyle
    };
    Q_ENUM(Style)

    QUIAlertController(QObject* parent = nullptr);
    ~QUIAlertController() override;

    QString message() const;
    void setMessage(const QString &msg);

    Style style() const;
    void setStyle(Style style);

    void createControllerAndPresent(QUIViewController* parent);

signals:
    void messageChanged();
    void styleChanged();

protected slots:
    virtual void childrenDidChanged() override;

private:
    QString m_message;
    Style m_style;
    QList<QUIAlertAction*> m_actions;
};

#endif // QUIALERTCONTROLLER_H
