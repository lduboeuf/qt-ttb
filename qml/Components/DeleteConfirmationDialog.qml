import QtQuick 2.0
import QtQuick.Controls 2.2

Dialog {
    id: confirmationDialog

    signal confirmed
    signal dismiss

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: Math.min(parent.width, parent.height) / 3 * 2
    parent: ApplicationWindow.overlay

    modal: true
    title: qsTr("Confirmation")
    standardButtons: Dialog.Yes | Dialog.No


    Label {
        //anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        wrapMode: Label.Wrap
        text: qsTr("You are about to remove data, please confirm")
    }



    onAccepted: {

        confirmed()
        //confirmationDialog.close()
    }

    onRejected: {
        dismiss()
    }
}
