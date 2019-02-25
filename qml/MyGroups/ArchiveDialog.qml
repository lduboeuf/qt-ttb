import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3



Dialog {
    id: archiveSaveDialog

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    parent: ApplicationWindow.overlay

    focus: true
    modal: true
    title: "Input"
    standardButtons: Dialog.Ok | Dialog.Cancel

    ColumnLayout {
        spacing: 20
        anchors.fill: parent
        Label {
            elide: Label.ElideRight
            text: "Please enter a name :"
            Layout.fillWidth: true
        }
        TextField {
            id: archiveName
            focus: true
            placeholderText: "archive name"
            Layout.fillWidth: true
        }
    }
}





