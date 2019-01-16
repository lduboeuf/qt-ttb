import QtQuick 2.6
import QtQuick.Controls 2.1

ScrollablePage {
    id: pageX


    Column {
        spacing: 40
        anchors.fill: parent

//        Label {
//            width: parent.width
//            wrapMode: Label.Wrap
//            horizontalAlignment: Qt.AlignHCenter
//            text: "SpinBox allows the user to choose an integer value by clicking the up or down indicator buttons, "
//                + "by pressing up or down on the keyboard, or by entering a text value in the input field."
//        }

//        SpinBox {
//            id: box
//            value: 50
//            anchors.horizontalCenter: parent.horizontalCenter
//            editable: true
//        }

        ListView {
            id: listView
            anchors.fill: parent
            model: ListModel {
                ListElement { name: "Bob Bobbleton"}
                ListElement { name: "Rug Emporium" }
            }
            delegate: SwipableItem{}
        }

    }
}

