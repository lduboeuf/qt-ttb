import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import "../Components"
import "../Model"


Page {
    id: bulkItemForm

    title: name + qsTr(" - Add members")



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




    Flickable {
        id: flickable
        anchors.margins: 16
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Qt.inputMethod && Qt.inputMethod.visible ? Qt.inputMethod.keyboardRectangle.height / Screen.devicePixelRatio : parent.height
        contentHeight: container.height + anchors.margins
        flickableDirection: Flickable.VerticalFlick



        Column {
            id:container
            spacing: 40
            anchors.margins:16
            //anchors.fill: parent
            width: parent.width
            //height: parent.height




            Repeater {
                id: fields


                onItemAdded:function(index, item){
                    if (index === count -1){ //only for last item
                        var keyboardHeight=  Qt.inputMethod && Qt.inputMethod.visible ? Qt.inputMethod.keyboardRectangle.height / Screen.devicePixelRatio : 0
                        console.log("keyboard: h:" +keyboardHeight)
                        console.log("header:" + bulkItemForm.header.height+" window height:" + bulkItemForm.height +" contentY:" + flickable.contentY + " height: " + flickable.height + " contentHeight:" + flickable.contentHeight)

                        var visibleHeight = bulkItemForm.contentHeight  - keyboardHeight
                        console.log("visibleHeight:" + visibleHeight)
                        var todisplay = flickable.contentHeight + item.height *3 - visibleHeight
                        if (todisplay > 0){
                            flickable.contentY = todisplay
                            flickable.returnToBounds()
                            console.log("overlayedHeight:" + todisplay)
                        }

                    }


                }

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
                        if (text.length!==0){
                            if (index == (fields.count -2)){ //only when the last - 1
                                itemModel.append({name:""})
                            }
                        }
                    }

                    Keys.onReturnPressed: {
                        //focus on next field
                        fields.itemAt(index+1).forceActiveFocus()
                    }


                }


            }
        }


        ScrollIndicator.vertical: ScrollIndicator { }


    }

    StackView.onActivated: fields.itemAt(0).forceActiveFocus() //focus on first element




}
