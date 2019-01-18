import QtQuick 2.9
import QtQuick.Controls 2.2

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
            value: 1
        }

        Label {

            text: qsTr("Members per team within:")
        }

        ComboBox {
            id: comboBox
            width: form.width
            model: ["kikou", "blabla", "blibli"]
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
            }
        }
    }

}
