import QtQuick 2.9
import QtQuick.Controls 2.2
import "." //Apparently pages that are not shown troughout stackView cannot load singleton TTBApplication

Page {
    id: toolBuild
    title: qsTr("Build Teams")

    property var selectedGroup: []

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
            model: TTBApplication.groupModel

            // ComboBox closes the popup when its items (anything AbstractButton derivative) are
                    //  activated. Wrapping the delegate into a plain Item prevents that.
            delegate: Item {
                width: parent.width
                height: checkDelegate.height

                function toggle() { checkDelegate.toggle() }

                CheckDelegate {
                    id: checkDelegate
                    anchors.fill: parent
                    text: model.name
                    highlighted: comboBox.highlightedIndex == index
                    checked: selectedGroup.indexOf(index) !== -1
                    onCheckedChanged: {
                        var idx = selectedGroup.indexOf(index)
                        if (idx === -1){
                            selectedGroup.push(index)
                        }else{
                            selectedGroup.splice(idx, 1)
                        }
                    }

                }
            }

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

                    console.log(selectedGroup)
                    selectedGroup = []

                }
            }
        }
    }

}
