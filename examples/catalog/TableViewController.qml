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

