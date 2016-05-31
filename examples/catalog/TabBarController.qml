import QtQml 2.0
import QtQuick 2.5
import jsee23.qmluikit 0.1

UITabBarController {
    UIViewController {
        title: "Eins"
        tabBarItem: UITabBarItem {
            title: "Eins"
            systemItem: UITabBarItem.Contacts
        }

        UIView {
            backgroundColor: "red"
        }
    }

    UIViewController {
        title: "Zwei"
        tabBarItem: UITabBarItem {
            title: "Zwei"
            systemItem: UITabBarItem.Recents
        }

        UIView {
            backgroundColor: "green"
        }
    }

    UIViewController {
        title: "Drei"
        tabBarItem: UITabBarItem {
            title: "Drei"
            imageSource: "qrc:/img/bullish.png"
        }

        UIView {
            backgroundColor: "yellow"
        }
    }
}
