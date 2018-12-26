# qmluikit
QML wrapper for UIKit classes

### Use the power of QML with UIKit
It isn't easy to create a native-looking UI with Qt on iOS devices. Therefore, qmluikit provides access to the iOS-native rendering through UIKit.
As every almost Qt developer is familiar with QML, qmluikit uses QML to create those UIs:
```
import QtQml 2.0
import jsee23.qmluikit 0.1

UIWindow {
    UIViewController {
        title: "my qmluikit app"

        UIButton {
            titleLabel: "Press me!"
            onClicked: {
                // do something special!
            }
        }
    }
}
```

Please take a look at the preliminary documentation at:

http://jsee23.github.io/qmluikit/

### Wishlist / Known Issues

* anchors aren't supported
* embed QtQuick into qmluikit application
* styling of the controls

### Build & Install
```
qmake
make
make install
```

