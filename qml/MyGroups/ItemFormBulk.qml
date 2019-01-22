import QtQuick 2.0
import QtQuick.Controls 2.1
import "../Components"
import "../Model"


Page {
    id: bulkItemForm

    title: groupId + qsTr(" - Add members")

    property int groupId:0
    property string name:""

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
                  source: "/assets/ok.svg"
              }

              onClicked: {
                save()
              }
           }
    }


    function save(){
        var items= []
        for (var i = 0; i < itemModel.count; i++) {
            var item = fields.itemAt(i).text.trim();
            if (item.length!==0){
                items.push(item)
            }
        }
        console.log("groupId insert:" + groupId)
        ItemModel.insertMembers(groupId, items)
        stackView.pop()


    }


    Column {
        spacing: 40
        anchors.margins:16
        anchors.fill: parent

    Repeater {
        id: fields
            model: ListModel{
                id:itemModel
                ListElement { name: ""}
                ListElement { name: ""}
                ListElement { name: ""}
            }


            delegate:  TextField {
                //id: memberInput
                id:input
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "Member name " + (index+1)
                onEditingFinished: {
                    console.log("index:" + index )
                    if (index == (fields.count -2)){
                        itemModel.append({name:""})
                        //var newItem = Qt.createComponent(input)
                        //newItem.createObject(fields, {"text": "Member name " + index })
                    }
                }


                //width: parent.width -this.height

            }


        }


    }




}
