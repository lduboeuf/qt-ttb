import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

PageTheme {
    id: pageX

    Column {
        spacing: 40
        anchors.fill: parent


        ListView {
            id: listView
            anchors.fill: parent
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: ListModel {
                ListElement { name: "Bob Bobbleton"}
                ListElement { name: "Rug Emporium" }
            }
            delegate: SwipableItem{

            }
        }

    }
}

