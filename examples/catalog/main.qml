import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIWindow {
    id: root
    initialViewController: navigationController

    property TableViewController tableViewController: TableViewController {}
    property SegmentedController segmentedController: SegmentedController {}

    UINavigationController {
        id: navigationController
        initialViewController: initialPage

        UITableViewController {
            id: initialPage
            title: "Catalog"

            sections: [
                UITableViewSection {
                    title: "ViewControllers"

                    UITableViewCell {
                        title: "UITableViewController"
                        onSelected: navigationController.pushViewController(root.tableViewController)
                    }
                    UITableViewCell {
                        title: "UISegmentedControl"
                        onSelected: navigationController.pushViewController(root.segmentedController)
                    }
                    UITableViewCell {
                        title: "UIToolbar"
                    }
                },
                UITableViewSection {
                    title: "Controls"

                    UITableViewCell {
                        title: "UIButton"
                    }
                    UITableViewCell {
                        title: "UISlider"
                    }
                    UITableViewCell {
                        title: "UISwitch"
                    }
                },
                UITableViewSection {
                    title: "Input"

                    UITableViewCell {
                        title: "todo"
                    }
                }

            ]
        }
    }
}
