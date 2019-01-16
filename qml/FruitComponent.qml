import QtQuick 2.0

Component {
        id: fruitDelegate
        Item {
            width: 200; height: 50
            Text { text: name }
            Text { text: '$' + cost; anchors.right: parent.right }

            // Double the price when clicked.
            MouseArea {
                anchors.fill: parent
                onClicked: fruitModel.setProperty(index, "cost", cost * 2)
            }
        }
    }
