#include "quitableviewcontroller.h"
#include <QSize>

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
    return control->qlistSections().size();
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return control->qlistSections().at(section)->cellsCount();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    return ((UITableViewCell*) control->qlistSections().at(indexPath.section)->cellItemAt(row)->nativeItem());
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return control->qlistSections().at(section)->title().toNSString();
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    int selectedRow = indexPath.row;
    emit control->qlistSections().at(indexPath.section)->cellItemAt(selectedRow)->selected();
}
@end

//////////////////////////
// Qt
//////////////////////////

QUITableViewController::QUITableViewController(QObject* parent) :
    QUIViewController(false, parent)
{
    m_nativeResource = [[QNative_UITableViewController alloc] init];
    ((QNative_UITableViewController*) m_nativeResource)->control = this;
}

QUITableViewController::~QUITableViewController()
{
}

QQmlListProperty<QUITableViewSection> QUITableViewController::sections()
{
    return QQmlListProperty<QUITableViewSection>(this, 0, &QUITableViewController::append_section,
                                                 0, 0, 0);
}

QList<QUITableViewSection *> QUITableViewController::qlistSections() const
{
    return m_sections;
}

void QUITableViewController::append_section(QQmlListProperty<QUITableViewSection> *list, QUITableViewSection *section)
{
    QUITableViewController *controller = qobject_cast<QUITableViewController *>(list->object);
    if (controller) {
        controller->m_sections.append(section);
    }
}
