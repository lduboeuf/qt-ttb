import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0
import "../Components"
import "../Model"



Page {
    id: membersPage

    title: groupName + qsTr(" Members")

    property int groupId: -1
    property string groupName

    onGroupIdChanged:{
        ItemModel.buildModel(groupId)
    }

     header:NavigationBar{

         rightActions:[
             Action{
                 id: actionOK
                 source: "/assets/add.svg"
                 onTriggered: function(){
                     stackView.push("qrc:/qml/MyGroups/ItemForm.qml", {groupId: groupId, groupName: groupName})
                 }

             }
         ]

     }



    Column {
        spacing: 40
       // width: parent.width
        anchors.fill: parent

        ListView {
            id: memberList
             width: parent.width
             height: parent.height
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: ItemModel.itemModel

            delegate: SwipableItem{

                iconSource : "/assets/starred.svg"

                onRemoveClicked: function(index){

                    ItemModel.deleteMember(index)
                }

                onEditClicked: function(index){
                    var data = memberList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/ItemForm.qml", {index: index,rowId: data.rowId, name:data.name, groupId:data.groupId})
                    swipe.close()

                }

                onItemClicked: function(index){
                    var data = memberList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/ItemForm.qml", {index: index,rowId: data.rowId, name:data.name, groupId:data.groupId})
                }
            }
        }

    }
}

