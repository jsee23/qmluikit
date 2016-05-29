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

import QtQuick 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UITableViewController {
    title: "UITableViewController"

    model: itemRows

    delegate: UITableViewCell {
        textLabel: modelData.label
        detailTextLabel: modelData.detailedText
        style: modelData.style
    }

    sections: [
        UITableViewSection {
            title: "StyleDefault"
            count: 2
        },
        UITableViewSection {
            title: "StyleValue1"
            count: 2
        },
        UITableViewSection {
            title: "StyleValue2"
            count: 2
        },
        UITableViewSection {
            title: "StyleSubtitle"
            count: 2
        }
    ]

    property list<QtObject> itemRows: [
        QtObject {
            property string label: "Lorem Ipsum"
            property string detailedText: "Dolor Sit"
            property int style: UITableViewCell.StyleDefault
        },
        QtObject {
            property string label: "Amet Consetetur"
            property string detailedText: "Sadipscing Elitr"
            property int style: UITableViewCell.StyleDefault
        },
        QtObject {
            property string label: "Lorem Ipsum"
            property string detailedText: "Dolor Sit"
            property int style: UITableViewCell.StyleValue1
        },
        QtObject {
            property string label: "Amet Consetetur"
            property string detailedText: "Sadipscing Elitr"
            property int style: UITableViewCell.StyleValue1
        },
        QtObject {
            property string label: "Lorem Ipsum"
            property string detailedText: "Dolor Sit"
            property int style: UITableViewCell.StyleValue2
        },
        QtObject {
            property string label: "Amet Consetetur"
            property string detailedText: "Sadipscing Elitr"
            property int style: UITableViewCell.StyleValue2
        },
        QtObject {
            property string label: "Lorem Ipsum"
            property string detailedText: "Dolor Sit"
            property int style: UITableViewCell.StyleSubtitle
        },
        QtObject {
            property string label: "Amet Consetetur"
            property string detailedText: "Sadipscing Elitr"
            property int style: UITableViewCell.StyleSubtitle
        }
    ]
}

