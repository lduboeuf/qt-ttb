import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"


Dialog {
    id: archiveDialog
    property string typeName
    property var toSave
    property Action actionButton


    x: (parent.width - width) / 2
    y: (parent.height - height) / 4
    parent: ApplicationWindow.overlay

    focus: true
    modal: true
    title: qsTr('Save to archive')
    standardButtons: Dialog.Ok | Dialog.Cancel

    ColumnLayout {
        spacing: 20
        anchors.fill: parent
        Label {
            elide: Label.ElideRight
            text: qsTr("Please enter a name :")
            Layout.fillWidth: true
        }
        TextField {
            id: archiveName
            focus: true
            placeholderText: qsTr("archive name")
            Layout.fillWidth: true
        }
    }

    onAccepted: {
        if (archiveName.text.length==0){
            actionButton.tooltipText = qsTr("Archive name cannot be empty")
        }else{
            ArchiveModel.save(typeName, archiveName.text, toSave)
            actionButton.tooltipText = qsTr('saved successfully')
        }

    }


}





