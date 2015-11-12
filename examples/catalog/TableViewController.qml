import QtQuick 2.0
import QtQuick 2.5
import de.jsee23.qmluikit 1.0

UITableViewController {
    title: "UITableViewController"

    sections: [
        UITableViewSection {
            title: "StyleDefault"

            UITableViewCell {
                textLabel: "Lorem Ipsum"
                detailTextLabel: "Dolor Sit"
            }

            UITableViewCell {
                textLabel: "Amet Consetetur"
                detailTextLabel: "Sadipscing Elitr"
            }
        },
        UITableViewSection {
            title: "StyleValue1"

            UITableViewCell {
                textLabel: "Lorem Ipsum"
                detailTextLabel: "Dolor Sit"
                style: UITableViewCell.StyleValue1
            }

            UITableViewCell {
                textLabel: "Amet Consetetur"
                detailTextLabel: "Sadipscing Elitr"
                style: UITableViewCell.StyleValue1
            }
        },
        UITableViewSection {
            title: "StyleValue2"

            UITableViewCell {
                textLabel: "Lorem Ipsum"
                detailTextLabel: "Dolor Sit"
                style: UITableViewCell.StyleValue2
            }

            UITableViewCell {
                textLabel: "Amet Consetetur"
                detailTextLabel: "Sadipscing Elitr"
                style: UITableViewCell.StyleValue2
            }
        },
        UITableViewSection {
            title: "StyleSubtitle"

            UITableViewCell {
                textLabel: "Lorem Ipsum"
                detailTextLabel: "Dolor Sit"
                style: UITableViewCell.StyleSubtitle
            }

            UITableViewCell {
                textLabel: "Amet Consetetur"
                detailTextLabel: "Sadipscing Elitr"
                style: UITableViewCell.StyleSubtitle
            }
        }
    ]
}

