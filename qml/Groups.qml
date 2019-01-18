import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0
import "Database.js" as DB



Page {
    id: groupPage

    title: qsTr("My Groups")

//    AddGroup{
//        id: addGroupPage
//        visible: false
//    }

//     Connections {
//             target: addGroupPage
//             ignoreUnknownSignals: true
//             onGroupAdded: function(name){
//                 var id = DB.insertGroup(name)
//                 listModel.append({id: id, name: name})
//             }
//         }

     header:NavigationBar{
         toolbarButtons: ToolButton {
               id: addActionBar
               anchors.right: parent.right
               contentItem: Image {
                   fillMode: Image.Pad
                   horizontalAlignment: Image.AlignHCenter
                   verticalAlignment: Image.AlignVCenter
                   sourceSize.width: parent.height - (parent.height * 0.4)
                   sourceSize.height: sourceSize.height
                   source: "../assets/add.svg"
               }

               onClicked: stackView.push("qrc:/qml/GroupForm.qml")
            }

     }



    StackView.onActivated: DB.findAllGroups()



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

            model: ListModel{

                    id: listModel
                   // Component.onCompleted: DB.findAllGroups()

            }

            delegate: SwipableItem{
                onRemoveClicked: function(index){
                    var data = groupList.model.get(index)
                    console.log("delete index:"+index)
                    DB.deleteGroup(data.rowid)
                    groupList.model.remove(index, 1)
                }

                onEditClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/GroupForm.qml", {rowid: data.rowid, name:data.name})
                }
            }
        }

    }
}
