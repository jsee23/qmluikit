import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIWindow {
    initialViewController: navigationController

    UINavigationController {
        id: navigationController
        initialViewController: initialPage

        UIViewController {
            id: initialPage
            title: "First"

            UIScrollView {
                width: initialPage.width
                height: initialPage.height
                contentWidth: width
                contentHeight: height * 2

                UIButton {
                    width: initialPage.width
                    titleLabel: "Button"
                }
                UIButton {
                    y: 100
                    width: initialPage.width
                    titleLabel: "Button"
                }
            }
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
