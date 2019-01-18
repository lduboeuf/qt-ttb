import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0
import "Database.js" as DB



Page {
    id: membersPage

    title: group_name + qsTr("Members")

    property string group_id
    property string group_name

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
                   source: "../assets/add.svg"
               }

               onClicked: stackView.push("qrc:/qml/MemberForm.qml", {group_id: group_id, group_name: group_name})
            }

     }



    StackView.onActivated: {
        DB.findAllMembers(group_id)
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

            model: ListModel{
                    id: listModel
            }

            delegate: SwipableItem{

                iconSource : "../assets/contact.svg"

                onRemoveClicked: function(index){
                    var data = memberList.model.get(index)
                    console.log("delete index:"+index)
                    DB.deleteMember(data.rowid)
                    memberList.model.remove(index, 1)
                }

                onEditClicked: function(index){
                    var data = memberList.model.get(index)
                    stackView.push("qrc:/qml/MemberForm.qml", {rowid: data.rowid, name:data.name, group_id:data.groupid})
                }
            }
        }

    }
}

