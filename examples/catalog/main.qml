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
                        textLabel: "UITableViewController"
                        onSelected: navigationController.pushViewController(root.tableViewController)
                    }
                    UITableViewCell {
                        textLabel: "UISegmentedControl"
                        detailTextLabel: "UIView"
                        style: UITableViewCell.StyleSubtitle
                        onSelected: navigationController.pushViewController(root.segmentedController)
                    }
                    UITableViewCell {
                        textLabel: "UIToolbar"
                    }
                },
                UITableViewSection {
                    title: "Controls"

                    UITableViewCell {
                        textLabel: "UIButton"
                    }
                    UITableViewCell {
                        textLabel: "UISlider"
                    }
                    UITableViewCell {
                        textLabel: "UISwitch"
                    }
                },
                UITableViewSection {
                    title: "Input"

                    UITableViewCell {
                        textLabel: "todo"
                    }
                }

            ]
        }
    }
}
