/****************************************************************************
**
** Copyright (C) 2016 Jochen Seemann
**
** This file is part of the qmluikit library.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
****************************************************************************/

import QtQml 2.0
import QtQuick 2.5
import jsee23.qmluikit 0.1

UIWindow {
    id: root

    property TableViewController tableViewController: TableViewController {}
    property SegmentedController segmentedController: SegmentedController {}
    property ButtonController buttonController: ButtonController {}
    property TabBarController tabBarController: TabBarController {}
    property AlertActionController alertActionController: AlertActionController {}

    UINavigationController {
        id: navigationController
        initialViewController: initialPage

        UITableViewController {
            id: initialPage
            title: "Catalog"

            model: subviews
            sections: [
                UITableViewSection {
                    title: "Controllers"
                    count: 3
                },
                UITableViewSection {
                    title: "Views"
                    count: 1
                },
                UITableViewSection {
                    title: "Controls"
                    count: 4
                },
                UITableViewSection {
                    title: "Input"
                    count: 1
                }

            ]

            delegate: UITableViewCell {
                textLabel: modelData.label
                onSelected: {
                    if (modelData.target) {
                        navigationController.pushViewController(modelData.target)
                    }
                }
            }

            property list<QtObject> subviews: [
                QtObject {
                    property string label: "UITableViewController"
                    property QtObject target: root.tableViewController
                },
                QtObject {
                    property string label: "UITabBarController"
                    property QtObject target: root.tabBarController
                },
                QtObject {
                    property string label: "UISegmentedControl"
                    property QtObject target: root.segmentedController
                },
                QtObject {
                    property string label: "UIActionSheet"
                    property QtObject target: root.alertActionController
                },
                QtObject {
                    property string label: "UIToolbar"
                },
                QtObject {
                    property string label: "UIButton"
                    property QtObject target: root.buttonController
                },
                QtObject {
                    property string label: "UISlider"
                },
                QtObject {
                    property string label: "UISwitch"
                },
                QtObject {
                    property string label: "todo"
                }

            ]
        }
    }
}
