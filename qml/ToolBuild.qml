import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0

import "Database.js" as DB

Page {
    id: toolBuild
    title: qsTr("Build Teams")

    Column {
        id: form
        anchors.fill: parent

        //anchors.top: parent.top
        anchors.margins:16
        spacing: 6
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            text: qsTr("Define:")
        }

        SpinBox {
            id: spinBox
            width: form.width
            from: 1
            to: 10
            value: 2
        }

        Label {

            text: qsTr("Members per team within:")
        }

        ComboBox {
            id: comboBox
            width: form.width
            textRole: "name"
            model: ListModel{
                id: listModel
            }
//            ItemDelegate {
//                   text: listModel.name
//            }
        }

        Row {
            id: row
            width: form.width
            topPadding: 8

            Button {
                id: button
                text: qsTr("OK")
                focusPolicy: Qt.ClickFocus
                width: form.width
                topPadding: 6
                //highlighted: true
                onClicked: {
                    var data = comboBox.model.get(comboBox.currentIndex)
                    console.log("selected group:" + data.name)
                    if (data.rowid ===-1){
                        console.log("tout selectionné")
                    }

                }
            }
        }
    }

    Component.onCompleted: {

        DB.findAllGroups()
        //add fake Item
        comboBox.model.insert(0, {rowid:-1, name: qsTr("All groups")})

    }

}
