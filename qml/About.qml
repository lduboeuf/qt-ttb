import QtQuick 2.9
import QtQuick.Controls 2.2

Page {


    title: qsTr("Page 2")

    Label {
        text: qsTr("You are on Page 2.")
        anchors.centerIn: parent
    }

    ListModel {
        id: fruitModel

        ListElement {
            name: "Apple"
            cost: 2.45
            type: "1"
        }
        ListElement {
            name: "Banana"
            cost: 1.95
            type: "1"
        }
        ListElement {
            name: "Orange"
            cost: 3.25
            type: "2"
        }
    }





    ListView {
        anchors.fill: parent
        model: fruitModel
        delegate: Text {
            text: name;
            font.pixelSize: 24
            anchors.left: parent.left
            anchors.leftMargin: 2
        }
        focus: true

        section {
            property: "type"
            criteria: ViewSection.FullString
            delegate: Rectangle {
                color: "#b0dfb0"
                width: parent.width
                height: childrenRect.height + 4
                Text { anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    font.bold: true
                    text: "kikou section " +section
                }
            }
        }
    }



    ComboBox {
        id: comboBox
        textRole: "name"
        model: fruitModel

        onCurrentIndexChanged:{
            console.log(fruitModel.get(currentIndex).cost)
            fruitModel.append({name: "zonote", type: "2", cost: 2.59})
        }
    }
}
