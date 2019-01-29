import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Components"
import "../Model"




Page {
    id: groupPage

    title: qsTr("My Groups")

     header:NavigationBar{

            rightActions:[
                Action{
                    source: "/assets/add.svg"
                    onTriggered: function(){
                        stackView.push("qrc:/qml/MyGroups/GroupForm.qml")
                    }

                }
            ]

     }


    Column {
        spacing: 40
       // width: parent.width
        anchors.fill: parent
        anchors.topMargin: 16

        ListView {
            id: groupList
             width: parent.width
             height: parent.height
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: GroupModel.groupModel

            delegate: SwipableItem{

               iconSource : GroupModel.getImageSource(model.type)

                onRemoveClicked: function(index){
                    GroupModel.removeGroup(index)
                }

                onEditClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/GroupForm.qml", {index: index, rowId: data.rowId, name:data.name, currentType:data.type})
                    swipe.close()
                }

                onItemClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/Items.qml", {groupId: data.rowId, groupName:data.name})
                }
            }

            section {
                property: "categoryName"
                criteria: ViewSection.FullString
                delegate: Text {
                    text: section
                    opacity: 0.60
                    padding: 8

                    Rectangle {
                        color: "lightgrey"
                        width: groupList.width
                        anchors.top: parent.bottom
                        height: 1

                    }
                }
            }
        }

    }
}
