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

#include "quitableviewcontroller.h"

#include <QSize>
#include <QJSValue>
#include <QtQml/QtQml>
#include <QtQml/private/qqmldelegatemodel_p.h>

//////////////////////////
// Objective-C
//////////////////////////

#include <UIKit/UIKit.h>

@interface QNative_UITableViewController : UITableViewController
{
    @public
    QUITableViewController* control;
}
@end

@implementation QNative_UITableViewController
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    control->setSize(QSize(size.width, size.height));
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGSize size = self.view.frame.size;
    control->setSize(QSize(size.width, size.height));
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    emit control->navigationBarGeometryChanged();
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(statusFrameChanged:)
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];

    control->setStatusBarHeight(MIN([UIApplication sharedApplication].statusBarFrame.size.height,
                              [UIApplication sharedApplication].statusBarFrame.size.width));
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]
        removeObserver:self
        name:UIApplicationDidChangeStatusBarFrameNotification
        object:nil];
    [super viewDidUnload];
}

- (void) statusFrameChanged:(NSNotification*)note
{
    CGRect statusBarFrame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    control->setStatusBarHeight(MIN(statusBarFrame.size.height,
                               statusBarFrame.size.width));
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return control->qlistSections().count();
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (control->qlistSections().count() == 0)
        return control->count();
    else
        return control->qlistSections().at(section)->count();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        itemIndex += control->qlistSections().at(i)->count();
    }
    itemIndex += indexPath.row;

    QUITableViewCell* cell = qobject_cast<QUITableViewCell*>(control->objectModel()->object(itemIndex, false));
    return ((UITableViewCell*) cell->nativeItem());
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return control->qlistSections().at(section)->title().toNSString();
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    int itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        itemIndex += control->qlistSections().at(i)->count();
    }
    itemIndex += indexPath.row;

    QUITableViewCell* cell = qobject_cast<QUITableViewCell*>(control->objectModel()->object(itemIndex, false));
    emit cell->selected();
}
@end

//////////////////////////
// Qt
//////////////////////////

/*!
 * \brief TODO: doc
 * \qmltype UIVTableViewController
 * \inqmlmodule jsee23.qmluikit
 *
 * TODO: doc
 *
 * \qml
 * import jsee23.qmluikit 0.1
 *
 * // ...
 *     UIVTableViewController {
 *         model: [ "Apple", "Banana", "Tomato" ]
 *         delegate: UITableViewCell {
 *             textLabel: modelData
 *         }
 *     }
 * // ...
 * \endqml
 */

QUITableViewController::QUITableViewController(QObject* parent) :
    QUIViewController(false, parent)
{
    m_nativeResource = [[QNative_UITableViewController alloc] init];
    ((QNative_UITableViewController*) m_nativeResource)->control = this;

    m_controllerView = new QUIView(((QNative_UITableViewController*) m_nativeResource).view, this);
}

QUITableViewController::~QUITableViewController()
{
    [((QNative_UITableViewController*) m_nativeResource) release];
}

/*!
 * \qmlproperty list<UITableViewSection> jsee23.qmluikit::UITableViewController::sections
 *
 * TODO: doc
 */
QQmlListProperty<QUITableViewSection> QUITableViewController::sections()
{
    return QQmlListProperty<QUITableViewSection>(this, 0, &QUITableViewController::append_section,
                                                 0, 0, 0);
}

QList<QUITableViewSection *> QUITableViewController::qlistSections() const
{
    return m_sections;
}

QPointer<QQmlInstanceModel> QUITableViewController::objectModel() const
{
    return m_model;
}

/*!
 * \qmlproperty var jsee23.qmluikit::UITableViewController::model
 *
 * TODO: doc
 */
QVariant QUITableViewController::model() const
{
    if (m_dataSourceIsObject) {
        QObject *o = m_dataSourceAsObject;
        return QVariant::fromValue(o);
    }

    return m_dataSource;
}

void QUITableViewController::setModel(const QVariant &m)
{
    QVariant model = m;
    if (model.userType() == qMetaTypeId<QJSValue>())
        model = model.value<QJSValue>().toVariant();

    if (m_dataSource == model)
        return;

    // TODO
    //[self.tableView beginUpdates];

    clear();
    if (m_model) {
//        qmlobject_disconnect(m_model, QQmlInstanceModel, SIGNAL(modelUpdated(QQmlChangeSet,bool)),
//                this, QUITableViewController, SLOT(modelUpdated(QQmlChangeSet,bool)));
//        qmlobject_disconnect(m_model, QQmlInstanceModel, SIGNAL(createdItem(int,QObject*)),
//                this, QUITableViewController, SLOT(createdItem(int,QObject*)));
//        qmlobject_disconnect(m_model, QQmlInstanceModel, SIGNAL(initItem(int,QObject*)),
//                this, QUITableViewController, SLOT(initItem(int,QObject*)));
    }
    m_dataSource = model;
    QObject *object = qvariant_cast<QObject*>(model);
    m_dataSourceAsObject = object;
    m_dataSourceIsObject = object != 0;
    QQmlInstanceModel *vim = 0;
    if (object && (vim = qobject_cast<QQmlInstanceModel *>(object))) {
        if (m_ownModel) {
            delete m_model;
            m_ownModel = false;
        }
        m_model = vim;
    } else {
        if (!m_ownModel) {
            m_model = new QQmlDelegateModel(qmlContext(this));
            m_ownModel = true;
            if (isComponentComplete())
                static_cast<QQmlDelegateModel *>(m_model.data())->componentComplete();
        }
        if (QQmlDelegateModel *dataModel = qobject_cast<QQmlDelegateModel*>(m_model))
            dataModel->setModel(model);
    }
    if (m_model) {
        qmlobject_connect(m_model, QQmlInstanceModel, SIGNAL(modelUpdated(QQmlChangeSet,bool)),
                this, QUITableViewController, SLOT(modelUpdated(QQmlChangeSet,bool)));
        qmlobject_connect(m_model, QQmlInstanceModel, SIGNAL(createdItem(int,QObject*)),
                this, QUITableViewController, SLOT(createdItem(int,QObject*)));
        qmlobject_connect(m_model, QQmlInstanceModel, SIGNAL(initItem(int,QObject*)),
                this, QUITableViewController, SLOT(initItem(int,QObject*)));
        regenerate();
    }
    emit modelChanged();
    emit countChanged();
}

/*!
 * \qmlproperty Component jsee23.qmluikit::UITableViewController::delegate
 *
 * TODO: doc
 */
QQmlComponent *QUITableViewController::delegate() const
{
    if (m_model) {
        if (QQmlDelegateModel *dataModel = qobject_cast<QQmlDelegateModel*>(m_model))
            return dataModel->delegate();
    }

    return 0;
}

void QUITableViewController::setDelegate(QQmlComponent *delegate)
{
    if (QQmlDelegateModel *dataModel = qobject_cast<QQmlDelegateModel*>(m_model))
       if (delegate == dataModel->delegate())
           return;

    if (!m_ownModel) {
        m_model = new QQmlDelegateModel(qmlContext(this));
        m_ownModel = true;
    }

    if (QQmlDelegateModel *dataModel = qobject_cast<QQmlDelegateModel*>(m_model)) {
        dataModel->setDelegate(delegate);
        regenerate();
        emit delegateChanged();
        m_delegateValidated = false;
    }
}

/*!
 * \qmlproperty int jsee23.qmluikit::UITableViewController::count
 *
 * TODO: doc
 */
int QUITableViewController::count() const
{
    return m_itemCount;
}

void QUITableViewController::componentComplete()
{
    m_componentCompleted = true;

    if (m_model && m_ownModel)
        static_cast<QQmlDelegateModel *>(m_model.data())->componentComplete();
    regenerate();
    if (m_model && m_model->count())
        emit countChanged();
}

void QUITableViewController::modelUpdated(const QQmlChangeSet &changeSet, bool reset)
{

    if (!isComponentComplete())
        return;

    if (reset) {
        regenerate();
        if (changeSet.difference() != 0)
            emit countChanged();
        return;
    }

    int difference = 0;
    foreach (const QQmlChangeSet::Change &remove, changeSet.removes()) {
        int index = qMin(remove.index, m_deletables.count());
        int count = qMin(remove.index + remove.count, m_deletables.count()) - index;
        while (count--) {
            QUITableViewCell *item = m_deletables.at(index);
            m_deletables.remove(index);
            emit itemRemoved(index, item);
            if (item) {
                m_model->release(item);
                //item->setParentItem(0);
            }
            --m_itemCount;
        }

        difference -= remove.count;
    }

    foreach (const QQmlChangeSet::Change &insert, changeSet.inserts()) {
        int index = qMin(insert.index, m_deletables.count());
        for (int i = 0; i < insert.count; ++i) {
            int modelIndex = index + i;
            ++m_itemCount;
            m_deletables.insert(modelIndex, 0);
            QObject *object = m_model->object(modelIndex, false);
            if (object)
                m_model->release(object);
        }
        difference += insert.count;
    }

    if (difference != 0)
        emit countChanged();
}

void QUITableViewController::createdItem(int index, QObject *)
{
    QObject *object = m_model->object(index, false);
    QUITableViewCell *item = qmlobject_cast<QUITableViewCell*>(object);
    emit itemAdded(index, item);

    if ((index + 1) == m_itemCount) {
        // TODO
        // [self.tableView endUpdates];

        [((QNative_UITableViewController*) m_nativeResource).tableView reloadData];
    }
}

void QUITableViewController::initItem(int /*index*/, QObject * /*item*/)
{
    // TODO: check delegate type, set needed context properties (if needed)
}

void QUITableViewController::append_section(QQmlListProperty<QUITableViewSection> *list, QUITableViewSection *section)
{
    QUITableViewController *controller = qobject_cast<QUITableViewController *>(list->object);
    if (controller) {
        controller->m_sections.append(section);
    }
}

void QUITableViewController::clear()
{
    bool complete = isComponentComplete();

    if (m_model) {
        // We remove in reverse order deliberately; so that signals are emitted
        // with sensible indices.
        for (int i = m_deletables.count() - 1; i >= 0; --i) {
            if (QUITableViewCell *item = m_deletables.at(i)) {
                if (complete)
                    emit itemRemoved(i, item);
                m_model->release(item);
                //item->setParentItem(0);
            }
        }
    }
    m_deletables.clear();
    m_itemCount = 0;
}

bool QUITableViewController::isComponentComplete()
{
    return m_componentCompleted;
}

void QUITableViewController::regenerate()
{
    if (!isComponentComplete())
        return;

    clear();

    if (!m_model || !m_model->count() || !m_model->isValid() || !isComponentComplete())
        return;

    m_itemCount = m_model->count();
    m_deletables.resize(m_itemCount);
    requestItems();
}

void QUITableViewController::requestItems()
{
    for (int i = 0; i < m_itemCount; i++) {
        QObject *object = m_model->object(i, false);
        if (object)
            m_model->release(object);
    }
}
