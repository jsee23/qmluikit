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

        backgroundColor: "red"
    }

    UIView {
        width: segmentedController.width
        y: segmentedControl.y + segmentedControl.height + 5
        height: segmentedController.height - y
        visible: segmentedControl.selectedSegment == 1

        backgroundColor: "green"
    }

    UIView {
        width: segmentedController.width
        y: segmentedControl.y + segmentedControl.height + 5
        height: segmentedController.height - y
        visible: segmentedControl.selectedSegment == 2

        backgroundColor: "blue"
    }
}

