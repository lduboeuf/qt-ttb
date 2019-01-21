import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import "../Components"
import "../Model"
//import GroupModel 1.0




Page {
    id: groupPage

    title: qsTr("My Groups")

     header:NavigationBar{
         toolbarButtons: ToolButton {
               id: addActionBar
               anchors.right: parent.right
               contentItem: Image {
                   fillMode: Image.Pad
                   horizontalAlignment: Image.AlignHCenter
                   verticalAlignment: Image.AlignVCenter
                   sourceSize.width: parent.height  * 0.4
                   sourceSize.height: sourceSize.height
                   source: "/assets/add.svg"
               }

               onClicked: stackView.push("qrc:/qml/MyGroups/GroupForm.qml")
            }

     }



    //StackView.onActivated: DB.findAllGroups()



    Column {
        spacing: 40
       // width: parent.width
        anchors.fill: parent

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
//                    var data = groupList.model.get(index)
//                    console.log("delete index:"+index)
//                    DB.deleteGroup(data.rowid)
//                    groupList.model.remove(index, 1)
                }

                onEditClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/GroupForm.qml", {index: index, rowid: data.rowid, name:data.name})
                    swipe.close()
                }

                onItemClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/Members.qml", {group_id: data.rowid, group_name:data.name})
                }
            }
        }

    }
}