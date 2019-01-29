import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import "../Components"
import "../Model"


ScrollablePage {
    id: addGroupPage

    property int index: 0
    property int rowId: 0
    property string name:""
    property string currentType:GroupModel.groupTypePeoplesName
    property int currentCategory : 0


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

        var categ = groupCategoryList.model.get(groupCategoryList.currentIndex)
        if (categ===null){
            return //TODO alert msg
        }
        var categid = categ.rowId


        if (updateMode){
            GroupModel.updateGroup(index, rowId, groupInput.displayText, selectedGroupType, categid)
        }else{
            rowId = GroupModel.addGroup(groupInput.displayText, selectedGroupType, categid)
        }

        console.log("new rowId:" + rowId + (typeof rowId))

        stackView.replace("qrc:/qml/MyGroups/ItemFormBulk.qml", {groupId: rowId, name: groupInput.displayText})
        groupInput.text = ""
    }

    padding: 16
    Column {
        spacing: 20
        anchors.fill: parent


        TextField {
            id: groupInput
            anchors.horizontalCenter:  parent.horizontalCenter

            placeholderText: "Group name"
            text:  name
            width: parent.width * 0.8
            maximumLength: 20

            onTextChanged: {
                actionOK.enabled = (text.length > 0) ? true: false
            }


            Keys.onReturnPressed: {
                save()
            }

        }


        Column {

            id: categoryContainer
            spacing: 6
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: groupInput.left

            Label{

                id: categoryContainerLabel
                //anchors.left: groupInput.left
                text: qsTr("Group category:")
            }
            Row{
                width: parent.width
                spacing:8
                height: groupCategoryList.height

                ComboBox {
                    id: groupCategoryList
                    width: parent.width
                    //height: 100
                    currentIndex: -1
                    textRole: "name"
                    model: CategoryModel.categoryModel

                }

                Image {
                    id: newCategoryButton

                    sourceSize.width: parent.height * 0.4
                    sourceSize.height: parent.height* 0.4
                    source: "/assets/add.svg"

                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.left: groupCategoryList.right

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {

                        }
                    }
                }


            }




//            Row {
//                width: parent.width
//                anchors.top: groupCategoryList.bottom
//                //anchors.horizontalCenter:  parent.horizontalCenter
//                TextField {
//                    id: newCategoryInput

//                    placeholderText: qsTr(" New category name")
//                    maximumLength: 20

//                }

//                Image {
//                    id: newCategoryButton

//                    sourceSize.width: newCategoryInput.height
//                    sourceSize.height: newCategoryInput.height
//                    source: "/assets/ok.svg"
//                    anchors.right: parent.right

//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: {
//                            if (newCategoryInput.length>0)
//                                CategoryModel.add(newCategoryInput.text)
//                        }
//                    }
//                }
//            }

        }



        Column {

            id: iconType
            spacing: 6
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: groupInput.left

            Label{

                id: lblGroupType
                anchors.topMargin: 20
                text: qsTr("Group type:")
            }

            ListView {
                id: groupTypeList
                width: parent.width
                height: 150
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
                        spacing: 8

                        Image {
                            id: icon

                            sourceSize.width: label.height
                            sourceSize.height: label.height
                            source: GroupModel.getImageSource(type)
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Label{
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
