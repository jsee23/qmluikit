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

            UIProgressView {
                id: progressView
                y: 20 + navigationController.navigationBarGeometry.height
                width: navigationController.navigationBarGeometry.width
                progress: 0.0
                progressAnimated: false

                Timer {
                    running: true
                    repeat: true
                    interval: 1000
                    onTriggered: {
                        if (progressView.progress >= 1.0)
                            progressView.progress = 0.0
                        else
                            progressView.progress += 0.1
                    }
                }
            }

            UIButton {
                y: 100
                titleLabel: "Klick mich!"
            }

            UIButton {
                titleLabel: "Blubb"
                x: 0
                y: 200
                width: 400
                height: 200
                onClicked: navigationController.pushViewController(secondController)
            }

            UISwitch {
                x: 100
                y: 300
                on: true
                onTintColor: "red"
            }

            UISlider {
                x: 100
                y: 400
            }

            UIDatePicker {
                x: 0
                y: initialPage.height - height
                width: initialPage.width
                height: 200
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
                y: 20 + navigationController.navigationBarGeometry.height + 5
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
