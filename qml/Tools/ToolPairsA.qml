import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
import "../Components"

Page {
    id: toolBuild
    title: qsTr("Find pairs")

    header:NavigationBar{

        subtitle: qsTr("left group")

        rightActions:[
            Action{
                id: actionNext
                source: "/assets/next.svg"
                enabled: false
                onTriggered: function(){
                    var selectedItems= []
                    for (var i =0; i < memberList.model.count; i++){
                        var row = memberList.model.get(i)
                        if (row.selected) selectedItems.push(row) //make sure we don't keep reference to model
                    }

                    stackView.push("qrc:/qml/Tools/ToolPairsB.qml", {selectedItems: selectedItems})
                }

            }
        ]
    }

    Column{
        //anchors.centerIn: parent
        anchors.topMargin: 20
        anchors.fill: parent
        spacing: 16
        Label {
            id:label
            width: parent.width * 0.8
            wrapMode: Label.Wrap
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Select left group:")
        }

        ComboBox{
            id:groupSelect
            anchors.horizontalCenter: parent.horizontalCenter
            textRole: "name"
            width: parent.width * 0.6
            currentIndex: -1
            model: GroupModel.groupModel

            onCurrentIndexChanged: {
                if (currentIndex>-1){

                    var list = ItemModel.findAllitems(groupSelect.model.get(currentIndex).rowId)
                    memberList.model.clear()
                    for (var i=0; i < list.length; i++){
                        memberList.model.append(list[i])
                    }
                }

            }
        }


        ListView {
            id: memberList
            width: parent.width
            height: parent.height



            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: ListModel{}

            delegate: CheckDelegate {
                id: sectionDelegate
                width:parent.width
                //anchors.fill: parent
                checked: selected
                text: name
                opacity: 0.60

                onCheckedChanged: {
                    memberList.model.get(index).selected = checked
                    if (checked) actionNext.enabled = true
                }

            }

            section {
                property: "groupId"
                criteria: ViewSection.FullString
                delegate: Item {
                    width: parent.width
                    height: sectionDelegate.height

                    Rectangle {
                        color: "lightgrey"
                        width: memberList.width
                        anchors.top: parent.bottom
                        height: 1

                    }

                    CheckDelegate {
                        id: sectionDelegate
                        anchors.fill: parent
                        text: " "
                        opacity: 0.60

                        onCheckedChanged: {

                            for (var i=0; i < memberList.model.count; i++){

                                memberList.model.get(i).selected = checked


                            }

                        }

                    }
                }
            }
        }


    }

    //    Component.onCompleted: {
    //        ItemModel.itemModel.clear()
    //        actionNext.enabled = false
    //        groupSelect.currentIndex = -1

    //    }

}



