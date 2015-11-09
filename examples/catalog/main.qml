import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIWindow {
    initialViewController: navigationController

    UINavigationController {
        id: navigationController
        initialViewController: initialPage

        UITableViewController {
            id: initialPage
            title: "Catalog"

            sections: [
                UITableViewSection {
                    title: "section 1"

                    UITableViewCell {
                        title: "cell 1"
                        onSelected: navigationController.pushViewController(secondController)
                    }
                    UITableViewCell {
                        title: "cell 2"
                    }
                },
                UITableViewSection {
                    title: "section 2"

                    UITableViewCell {
                        title: "cell 1"
                    }
                    UITableViewCell {
                        title: "cell 2"
                    }
                    UITableViewCell {
                        title: "cell 3"
                    }
                }

            ]
        }

        UIViewController {
            id: secondController
            title: "Second"

            UISegmentedControl {
                id: segmentedControl
                items: [
                    "Eins", "Zwei", "Drei"
                ]
                width: secondController.width - 10
                y: navigationController.statusBarHeight +
                   navigationController.navigationBarGeometry.height + 5
                x: 5
            }

            UIView {
                width: secondController.width
                y: segmentedControl.y + segmentedControl.height + 5
                height: secondController.height - y
                visible: segmentedControl.selectedSegment == 0

                UIButton {
                    y: 300
                    titleLabel: "First"
                }
            }

            UIToolbar {
                y: secondController.height - height
                width: secondController.width

                UIBarButtonItem {
                    title: "Test1"
                }

                UIBarButtonItem {
                    title: "Test2"
                    onClicked: console.log("Test...")
                }
            }
        }
    }
}
