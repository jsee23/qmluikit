# qmluikit
QML-Wrapper for UIKit classes - Qt for iOS port

### Idea
The base idea of qmluikit is to provide the native UIKit controls easily in the QML language. You can use the great cross-platform API's of the Qt framework and create a unique, platform-depending, but native & intuitive UI for your users.

### Current state
The currently implemented controls are:
* UIAlertController, UIAlertAction, UIBarButtonItem, UIButton, UIControl, UIDatePicker, UINavigationController, UIProgressView, UIScrollView, UISegmentedControl, UISlider, UISwitch, UITabBarController, UITabBarItem, UITableViewCell, UITableViewController, UITableViewSection(*), UIToolbar, UIView, UIViewController, UIWindow

(*) not part of the UIKit framework

IMPORTANT: the implementations of these classes are very basic, e.g. styling is missing right now.

### Try things out
```
qmake
make
make install
```

