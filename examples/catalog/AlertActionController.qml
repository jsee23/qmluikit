import QtQml 2.0
import QtQuick 2.5
import jsee23.qmluikit 0.1

UIViewController {
    id: buttonController

    title: "UIActionController"

    UIButton {
        x: (buttonController.width - width) / 2
        y: 150
        width: 200
        titleLabel: "Show ActionSheet"
        onClicked: buttonController.presentViewController(actionSheetController)
    }

    UIButton {
        x: (buttonController.width - width) / 2
        y: 300
        width: 200
        titleLabel: "Show AlertView"
        onClicked: buttonController.presentViewController(alertViewController)
    }

    UIAlertController {
        id: actionSheetController

        UIAlertAction {
            title: "OK"
            style: UIAlertAction.DestructiveStyle
            onClicked: console.log("clicked OK")
        }
        UIAlertAction {
            title: "Cancel"
            style: UIAlertAction.CancelStyle
            onClicked: console.log("clicked Cancel")
        }
    }

    UIAlertController {
        id: alertViewController
        style: UIAlertController.AlertStyle

        title: "AlertView title"
        message: "an important message for your user"

        UIAlertAction {
            title: "Cancel"
            onClicked: console.log("clicked Cancel")
        }
        UIAlertAction {
            title: "OK"
            onClicked: console.log("clicked OK")
        }
    }
}
