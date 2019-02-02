import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
import "./tools.js" as Tools

Page {
    id: toolBuild
    title: qsTr("Build Teams")

    //property string subtitle: qsTr("Build Teams")
    property var selectedGroup: []

    Column {
        id: form
        anchors.centerIn: parent


        spacing: 24


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Define:")
        }

        SpinBox {
            id: spinBox
            //width: form.width * 0.6
            //anchors.horizontalCenter: parent.horizontalCenter
            height: implicitHeight * 1.6

            from: 2
            to: 10
            value: 2



        }


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Members per team within:")
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

                stackView.push("qrc:/qml/Tools/ToolGroupSelect.qml", {nbItems: spinBox.value})

            }
        }






    }

}
