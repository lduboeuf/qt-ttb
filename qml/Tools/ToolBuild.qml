import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
//import "." //Apparently pages that are not shown troughout stackView cannot load singleton TTBApplication

import "./tools.js" as Tools

Page {
    id: toolBuild
    title: qsTr("Build Teams")

    property var selectedGroup: []

    Column {
        id: form
        anchors{
            left:parent.left
            top:parent.top
            right: parent.right
            margins: 16
        }

        //anchors.fill: parent


        //anchors.top: parent.top
        //anchors.margins:16
        spacing: 6
        //anchors.horizontalCenter: parent.horizontalCenter




        Label {
            text: qsTr("Define:")
        }

        SpinBox {
            id: spinBox
            width: form.width * 0.6
            anchors.horizontalCenter: parent.horizontalCenter

            from: 1
            to: 10
            value: 2
        }


        Label {

            text: qsTr("Members per team within:")
        }

        Button {
            id: buttonSelect
            text: qsTr("select")
            focusPolicy: Qt.ClickFocus
            width: form.width
            topPadding: 6
            //highlighted: true
            onClicked: {

                   stackView.push("qrc:/qml/Tools/ToolGroupSelect.qml", {nbItems: spinBox.value})

            }
        }



//        ComboBox {
//            id: comboBox
//            width: parent.width
//            textRole: "name"
//            model: GroupModel.groupModel



//            function clear(){ //clear all checked
//                console.log("length:" +comboBox.contentItem.children.length)
//                    for (var i = 0; i < comboBox.contentItem.children.length; i++){
//                        console.log("cb:" +comboBox.contentItem.children[child].text)
//                        comboBox.contentItem.children[child].checked = false
//                    }

//            }


//            // ComboBox closes the popup when its items (anything AbstractButton derivative) are
//            //  activated. Wrapping the delegate into a plain Item prevents that.
//            delegate: Item {
//                width: parent.width
//                height: (model.type===GroupModel.groupTypePeoplesName) ? checkDelegate.height: 0 //only display people type groups

//                function toggle() { checkDelegate.toggle() }

//                CheckDelegate {
//                    id: checkDelegate
//                    anchors.fill: parent
//                    text: model.name
//                    highlighted: comboBox.highlightedIndex == index
//                    checked: selectedGroup.indexOf(index) !== -1
//                    onCheckedChanged: {
//                        var idx = selectedGroup.indexOf(rowId)
//                        if (idx === -1){
//                            selectedGroup.push(rowId)
//                        }else{
//                            selectedGroup.splice(idx, 1)
//                        }
//                    }

//                }
//            }

//        }


//        Row {
//            id: rowAction
//            width: parent.width
//            topPadding: 8
//            //anchors.top: comboBox.bottom

//            Button {
//                id: button
//                text: qsTr("OK")
//                focusPolicy: Qt.ClickFocus
//                width: form.width
//                topPadding: 6
//                //highlighted: true
//                onClicked: {
//                    //                    var data = comboBox.model.get(comboBox.currentIndex)
//                    //                    console.log("selected group:" + data.name)
//                    //                    if (data.rowid ===-1){
//                    //                        console.log("tout selectionné")
//                    //                    }

//                    console.log(selectedGroup)
//                    if (selectedGroup.length == 0 ) return //don't do nothing
//                    var list = ItemModel.findAllitems(selectedGroup)

//                    var newList = Tools.build(list,spinBox.value )

//                    resultList.model.clear()
//                    for (var i=0; i < newList.length; i++){
//                        resultList.model.append(newList[i])
//                    }



//                    selectedGroup = []
//                    comboBox.clear()


//                }
//            }
//        }

//}

//        ListView {
//            id:resultList
//           // width: parent.width
//            anchors {
//                left: parent.left
//                top: form.bottom
//                right: parent.right
//                bottom: parent.bottom
//                margins:16
//            }
//            clip: true

//            //anchors.top:rowAction.bottom
//            //height: parent.bottom - rowAction.bottom
//            //anchors.bottom: parent.bottom

//            //anchors.bottom: parent.bottom
//            model: ListModel{

//            }


//            delegate: Text {
//                text: name;
//                font.pixelSize: 24
//                anchors.left: parent.left
//                anchors.leftMargin: 2
//            }
//            focus: true

//            section {
//                property: "groupName"
//                criteria: ViewSection.FullString
//                delegate: Rectangle {
//                    color: "#b0dfb0"
//                    width: parent.width
//                    height: childrenRect.height + 4
//                    Text { anchors.horizontalCenter: parent.horizontalCenter
//                        font.pixelSize: 16
//                        font.bold: true
//                        text: "kikou section " +section
//                    }
//                }
//            }

//            //Layout.fillWidth: true
//            //Layout.fillHeight: true

//            ScrollBar.vertical: ScrollBar {}
//        }


    }

}
