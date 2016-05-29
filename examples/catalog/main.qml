import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIWindow {
    id: root
    initialViewController: navigationController

    property TableViewController tableViewController: TableViewController {}
    property SegmentedController segmentedController: SegmentedController {}
    property ButtonController buttonController: ButtonController {}

    UINavigationController {
        id: navigationController
        initialViewController: initialPage

        UITableViewController {
            id: initialPage
            title: "Catalog"

            model: subviews
            sections: [
                UITableViewSection {
                    title: "Controllers"
                    count: 2
                },
                UITableViewSection {
                    title: "Controls"
                    count: 4
                },
                UITableViewSection {
                    title: "Input"
                    count: 1
                }

            ]

            delegate: UITableViewCell {
                textLabel: modelData.label
                onSelected: {
                    if (modelData.target) {
                        navigationController.pushViewController(modelData.target)
                    }
                }
            }

            property list<QtObject> subviews: [
                QtObject {
                    property string label: "UITableViewController"
                    property QtObject target: root.tableViewController
                },
                QtObject {
                    property string label: "UISegmentedControl"
                    property QtObject target: root.segmentedController
                },
                QtObject {
                    property string label: "UIToolbar"
                },
                QtObject {
                    property string label: "UIButton"
                    property QtObject target: root.buttonController
                },
                QtObject {
                    property string label: "UISlider"
                },
                QtObject {
                    property string label: "UISwitch"
                },
                QtObject {
                    property string label: "todo"
                }

            ]
        }
    }
}
