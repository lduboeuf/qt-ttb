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
    property string currentType:GroupModel.groupTypePeoplesName

    property bool updateMode: name.length==0 ? false: true

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

        var selectedGroupType = groupTypeList.model.get(groupTypeList.currentIndex).type

        console.log("groupType:" + selectedGroupType)

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
            anchors.left: parent.left
            text: qsTr("Group type:")
        }




        Column {

            id: iconType
            spacing: 6
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {
                id: groupTypeList
                width: parent.width
                height: 200
                currentIndex: 0

                model: ListModel{
                    ListElement {
                        name: qsTr("Peoples")
                        type: "peoples"
                    }
                    ListElement {
                        name: qsTr("Items")
                        type: "items"
                    }
                    ListElement {
                        name: qsTr("Tasks")
                        type: "tasks"
                    }
                }

                delegate: RadioDelegate {
                    text: name
                    width: parent.width
                    checked: currentType===type ? true: false
                    onClicked: groupTypeList.currentIndex = index

                    padding:0

                    contentItem: Row{
                        spacing: 16

                        Image {
                            id: icon


                            //anchors.centerIn: parent
                            sourceSize.width: label.height
                            sourceSize.height: label.height
                            source: GroupModel.getImageSource(type)
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Label{
                            //anchors.horizontalCenter: iconType.horizontalCenter
                            id: label
                            text: name
                            anchors.verticalCenter: parent.verticalCenter


                        }
                    }
                }
            }






        }
    }

    StackView.onActivated: groupInput.forceActiveFocus()




}
