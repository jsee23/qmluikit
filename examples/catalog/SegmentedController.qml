import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIViewController {
    id: segmentedController
    title: "Segmented Control"

    UISegmentedControl {
        id: segmentedControl
        items: [
            "Eins", "Zwei", "Drei"
        ]
        width: segmentedController.width - 10
        y: navigationController.statusBarHeight +
           navigationController.navigationBarGeometry.height + 5
        x: 5
    }

    UIView {
        width: segmentedController.width
        y: segmentedControl.y + segmentedControl.height + 5
        height: segmentedController.height - y
        visible: segmentedControl.selectedSegment == 0

        UIButton {
            y: 300
            titleLabel: "First"
        }
    }

    UIToolbar {
        y: segmentedController.height - height
        width: segmentedController.width

        UIBarButtonItem {
            title: "Test1"
        }

        UIBarButtonItem {
            title: "Test2"
            onClicked: console.log("Test...")
        }
    }
}

