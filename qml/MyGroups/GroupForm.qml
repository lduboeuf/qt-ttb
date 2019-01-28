import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import "../Components"
import "../Model"


Page {
    id: addGroupPage

    property int index: 0
    property int rowId: 0
    property string name:""
    property string type:GroupModel.groupTypePeoplesName

    property bool updateMode: name.length==0 ? false: true
    property string selectedGroupType: GroupModel.groupTypePeoplesName

    title: updateMode ? qsTr("Modify Group"): qsTr("Add Group")



    header:NavigationBar{

        rightActions:[
            Action{
                id: actionOK
                source: "/assets/ok.svg"
                enabled: false
                onTriggered: function(){
                    save()
                }

            }
        ]
    }

    function save(){
        if ( groupInput.displayText.trim() == "" ) {
            return
        }


        if (updateMode){
            GroupModel.updateGroup(index, rowId, groupInput.displayText, selectedGroupType)
        }else{
            rowId = GroupModel.addGroup(groupInput.displayText, selectedGroupType)
        }

        console.log("new rowId:" + rowId + (typeof rowId))

        stackView.replace("qrc:/qml/MyGroups/ItemFormBulk.qml", {groupId: rowId, name: groupInput.displayText})
        groupInput.text = ""
    }

    padding: 16
    Column {
        spacing: 20
        width: parent.width
        //anchors.margins:16
        //anchors.fill: parent
        //anchors.horizontalCenter:  parent.horizontalCenter

        TextField {
            id: groupInput
            //focus: true
            anchors.horizontalCenter:  parent.horizontalCenter

            //anchors.horizontalCenter:  parent.horizontalCenter
            placeholderText: "Group name"
            text:  name
            width: parent.width * 0.8
            maximumLength: 20

            onDisplayTextChanged: {
                actionOK.enabled = (groupInput.length > 0) ? true: false
            }

            Keys.onReturnPressed: {
                save()
            }

        }

        Label{

            id: lblGroupType
            anchors.topMargin: 20
            //anchors.top: groupInput.bottom
            anchors.left: groupInput.left
            text: qsTr("Group type:")
        }


        Column {

            id: iconType
            spacing: 6
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter



                RadioButton {
                    checked: type===GroupModel.groupTypePeoplesName ? true: false
                    //implicitHeight: 40
                    //implicitWidth: implicitHeight

                    padding:0
                    onCheckedChanged:if (checked) selectedGroupType = GroupModel.groupTypePeoplesName
                    implicitWidth: 100

                    contentItem: RowLayout{
                        anchors.left: parent.right


                        Image {
                            id: peopleImg


                            //anchors.centerIn: parent
                            sourceSize.width: peopleLabel.height
                            sourceSize.height: peopleLabel.width
                            source: GroupModel.getImageSource(GroupModel.groupTypePeoplesName)
                        }
                        Label{
                            //anchors.horizontalCenter: iconType.horizontalCenter

                            id: peopleLabel
                            text: qsTr("Peoples")


                        }

                    }


                }

  //          }


            RadioButton {

                checked: type===GroupModel.groupTypeItemsName ? true: false
                //implicitHeight: 30
                implicitWidth: 100
                padding:0

                onCheckedChanged:if (checked) selectedGroupType = GroupModel.groupTypeItemsName



                contentItem: RowLayout{
                    anchors.left: parent.right


                    Image {
                        id: itemImg

                        //anchors.centerIn: parent
                        sourceSize.width: itemLabel.height
                        sourceSize.height: itemLabel.width
                        source: GroupModel.getImageSource(GroupModel.groupTypeItemsName)
                    }
                    Label{
                        id: itemLabel
                        text: qsTr("Items")
                    }

                }


            }

////            }

////        Row{
            RadioButton {
                checked: type===GroupModel.groupTypeTasksName ? true: false

                implicitHeight: 30
                implicitWidth: 100
                padding:0
                onCheckedChanged:if (checked) selectedGroupType = GroupModel.groupTypeTasksName

                contentItem: RowLayout{


                    spacing:4
                    anchors.left: parent.right
                    Image {
                        id: taskImg

                        sourceSize.width: taskLabel.height
                        sourceSize.height: taskLabel.width
                        source: GroupModel.getImageSource(GroupModel.groupTypeTasksName)
                    }
                    Label{
                        id:taskLabel
                        text: qsTr("Tasks")
                    }

                }

            }


        }
    }

    StackView.onActivated: groupInput.forceActiveFocus()




}
