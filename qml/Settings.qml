import QtQuick 2.6
import QtQuick.Controls 2.2
import "Model"
import "Components"

Page {
    id: settings

    title: qsTr('Settings')
    header:NavigationBar{}

    Column {
        spacing: 40
        width: parent.width
        padding: 16
        Label {
            width: parent.width
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            text: qsTr("Reset datas: (long press the button)")
        }

        DelayButton {
            id:deleteButton
            enabled : true
            text: qsTr('OK')
            anchors.horizontalCenter: parent.horizontalCenter
            onActivated: {
                confirmationDialog.open()
            }
        }
    }
    Dialog {
        id: confirmationDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column {
            spacing: 20
            anchors.fill: parent
            Label {
                text: qsTr("Are you sure you want to delete all datas ?")
            }

        }

        onAccepted: {
            Database.dbReset()
            GroupModel.groupModel.clear()
            confirmationDialog.close()

        }
    }

}
