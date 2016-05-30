import QtQml 2.0
import QtQuick 2.5
import jsee23.qmluikit 0.1

UITabBarController {
    UIViewController {
        title: "Eins"
        tabBarItem: UITabBarItem {
            title: "Eins"
        }

        UIView {
            backgroundColor: "red"
        }
    }

    UIViewController {
        title: "Zwei"
        tabBarItem: UITabBarItem {
            title: "Zwei"
        }

        UIView {
            backgroundColor: "green"
        }
    }

    UIViewController {
        title: "Drei"
        tabBarItem: UITabBarItem {
            title: "Drei"
        }

        UIView {
            backgroundColor: "yellow"
        }
    }
}
