import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
//import TTBApplication 1.0


Page {
    id: addGroupPage

    property int index: 0
    property int rowid:0
    property string name:""

    property bool updateMode: name.length==0 ? false: true
    property string selectedGroupType: TTBApplication.groupTypePeoplesName

    title: updateMode ? qsTr("Modify Group"): qsTr("Add Group")


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
                source: "../assets/ok.svg"
            }

            onClicked: {
                save()
            }
        }
    }

    function save(){
        if ( groupInput.displayText.trim() == "" ) {
            return
        }


        if (updateMode){
            //DB.updateGroup(rowid, groupInput.displayText)
            TTBApplication.updateGroup(index, rowid, groupInput.displayText, selectedGroupType)
        }else{
            TTBApplication.addGroup(groupInput.displayText, selectedGroupType)
            //DB.insertGroup(groupInput.displayText)
        }

        groupInput.text = ""
        stackView.pop()
    }

    padding: 16
    Column {
        spacing: 20
        //anchors.margins:16
        width: parent.width
        //anchors.horizontalCenter:  parent.AlignHCenter


        TextField {
            id: groupInput
            //anchors.horizontalCenter:  parent.horizontalCenter
            placeholderText: "Group name"
            text:  name
            width: parent.width * 0.8

            Keys.onReturnPressed: {
                save()
            }

        }

        Label{
            text: qsTr("Group type:")
        }


        Column {
            id: iconType
            spacing: 4
            width: parent.width


            RadioButton {
                checked: true
                implicitHeight: 30
                implicitWidth: implicitHeight
                padding:0

                anchors.margins: 0
                onCheckedChanged:if (checked) selectedGroupType = TTBApplication.groupTypePeoplesName

                contentItem: RowLayout{
                    spacing:4
                    anchors.left: parent.right

                    width: parent.width
                    height: parent.height
                    Image {
                        id: peopleImg

                        //anchors.centerIn: parent
                        sourceSize.width: peopleLabel.height
                        sourceSize.height: peopleLabel.width
                        source: "../assets/contact-group.svg"
                    }
                    Label{
                        id: peopleLabel
                        text: qsTr("Peoples")


                    }

                }


            }
            RadioButton {

                checked: false
                implicitHeight: 30
                implicitWidth: implicitHeight
                padding:0

                onCheckedChanged:if (checked) selectedGroupType = TTBApplication.groupTypeItemsName



                contentItem: RowLayout{
                    anchors.left: parent.right

                    //anchors.leftMargin: 16
                    width: parent.width
                    height: parent.height
                    implicitHeight: 30
                    spacing:4


                    Image {
                        id: itemImg

                        //anchors.centerIn: parent
                        sourceSize.width: itemLabel.height
                        sourceSize.height: itemLabel.width
                        source: "../assets/items.svg"
                    }
                    Label{
                        id: itemLabel
                        text: qsTr("Items")
                    }

                }


            }
            RadioButton {
                checked: false

                implicitHeight: 30
                implicitWidth: implicitHeight
                padding:0
                onCheckedChanged:if (checked) selectedGroupType = TTBApplication.groupTypeTasksName

                contentItem: RowLayout{
                    //anchors.leftMargin: 16
                    width: parent.width
                    height: parent.height

                    spacing:4
                    anchors.left: parent.right
                    Image {
                        id: taskImg

                        //anchors.centerIn: parent
                        sourceSize.width: taskLabel.height
                        sourceSize.height: taskLabel.width
                        source: "../assets/groups.svg"
                    }
                    Label{
                        id:taskLabel
                        text: qsTr("Tasks")
                    }

                }

            }

        }
    }





}
