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
    id: buttonController
    title: "UIButton"

    UIButton {
        id: activeButton
        x: (buttonController.width - width) / 2
        y: (buttonController.height - height) / 2
        titleLabel: "Click me!"
        onClicked: buttonController.clickCount++
    }

    property int clickCount: 0

    UILabel {
        x: (buttonController.width - width) / 2
        y: 150
        width: buttonController.width - 200
        textAlignment: UILabel.NSTextAlignmentCenter

        text: "click count: " + buttonController.clickCount
    }
}

