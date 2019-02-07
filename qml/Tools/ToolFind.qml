import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
import "./tools.js" as Tools

Page {
    id: toolBuild
    title: qsTr("Find members")


    Column {
        id: form
        anchors.centerIn: parent

        spacing: 24


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Find:")
        }

        SpinBox {
            id: spinBox

            from: 1
            to: 10
            value: 1



        }


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Members within:")
        }

        Button {
            id: buttonSelect
            text: qsTr("select")
            focusPolicy: Qt.ClickFocus
            //height: implicitHeight * 1.6
            width: form.width * 0.6
            anchors.horizontalCenter: parent.horizontalCenter

            topPadding: 6
            //highlighted: true
            onClicked: {

                stackView.push("qrc:/qml/Tools/ToolGroupSelect.qml", {nbItems: spinBox.value, target:"qrc:/qml/Tools/ToolFindResult.qml", contextTitle: title})

            }
        }






    }

}
