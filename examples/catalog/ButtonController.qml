import QtQml 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UIViewController {
    id: buttonController
    title: "UIButton"

    UIButton {
        x: (buttonController.width - width) / 2
        y: 300
        titleLabel: "titleLabel"
    }
}

