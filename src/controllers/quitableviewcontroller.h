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

#ifndef QUITABLEVIEWCONTROLLER_H
#define QUITABLEVIEWCONTROLLER_H

#include <QPointer>
#include <QVector>
#include <QtQml/private/qqmlobjectmodel_p.h>
#include <QtQml/QQmlComponent>

#include "quiviewcontroller.h"
#include "quitableviewsection.h"

class QUITableViewController : public QUIViewController
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<QUITableViewSection> sections READ sections
               NOTIFY sectionsChanged)
    Q_PROPERTY(QVariant model READ model WRITE setModel NOTIFY modelChanged)
    Q_PROPERTY(QQmlComponent *delegate READ delegate WRITE setDelegate NOTIFY delegateChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)

    Q_INTERFACES(QQmlParserStatus)

public:
    QUITableViewController(QObject* parent = nullptr);
    ~QUITableViewController() override;

    QQmlListProperty<QUITableViewSection> sections();
    QList<QUITableViewSection*> qlistSections() const;

    QPointer<QQmlInstanceModel> objectModel() const;

    QVariant model() const;
    void setModel(const QVariant &);

    QQmlComponent *delegate() const;
    void setDelegate(QQmlComponent *);

    int count() const;

protected:
    virtual void componentComplete() override;

signals:
    void sectionsChanged();
    void modelChanged();
    void delegateChanged();
    void countChanged();

    void itemAdded(int index, QUITableViewCell *item);
    void itemRemoved(int index, QUITableViewCell *item);

private slots:
    void modelUpdated(const QQmlChangeSet &changeSet, bool reset);
    void createdItem(int index, QObject *item);
    void initItem(int index, QObject *item);

private:
    static void append_section(QQmlListProperty<QUITableViewSection> *list,
                               QUITableViewSection *slice);

    void clear();
    bool isComponentComplete();
    void regenerate();
    void requestItems();

    QList<QUITableViewSection*> m_sections;

    QVariant m_dataSource;
    QPointer<QQmlInstanceModel> m_model;
    QPointer<QObject> m_dataSourceAsObject;
    bool m_dataSourceIsObject : 1;
    bool m_ownModel : 1;
    bool m_delegateValidated : 1;
    int m_itemCount;
    bool m_componentCompleted = false;
    QVector<QPointer<QUITableViewCell>> m_deletables;
};

#endif // QUITABLEVIEWCONTROLLER_H
