import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
import "../Components"

Page {
    id: toolPairsB
    title: qsTr("Find pairs")

    property var selectedItems

    function isASelectedItem(id){
        for (var i =0; i < selectedItems.length; i++){
            if (selectedItems[i].rowId===id){
                return true;
            }
        }
        return false;
    }

    header:NavigationBar{

        subtitle: qsTr("right group")

        rightActions:[
            Action{
                id: actionOK
                source: "/assets/ok.svg"
                enabled: false
                onTriggered: function(){

                    var selectedItemsB= []
                    for (var i =0; i < memberList.model.count; i++){
                        var row = memberList.model.get(i)
                        if (row.selected) selectedItemsB.push(row)
                    }

                    stackView.push("qrc:/qml/Tools/ToolPairsResult.qml", {itemsLeft: selectedItems, itemsRight: selectedItemsB})
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
            text: qsTr("Select right group:")
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
                property bool selectedFromA: isASelectedItem(rowId)
                //anchors.fill: parent
                checked: selected | selectedFromA
                enabled: !selectedFromA
                text: name
                opacity: 0.60

                onCheckedChanged: {
                    if (!selectedFromA){
                        memberList.model.get(index).selected = checked
                        if (checked) actionOK.enabled = true
                    }



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



}



