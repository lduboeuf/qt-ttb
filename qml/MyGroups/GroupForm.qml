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
    property int currentCategoryId : 0


    property bool updateMode: name.length==0 ? false: true

    title: (name.length>0) ? name: qsTr('My Groups')



    header:NavigationBar{

        subtitle: updateMode ? qsTr("Edit Group"): qsTr("Add Group")


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

    onCurrentCategoryIdChanged: {
        for (var i=0; i < groupCategoryList.model.count ; i ++){
            if (currentCategoryId===groupCategoryList.model.get(i).rowId){
                groupCategoryList.currentIndex = i
                break;
            }
        }


    }

    function save(){
        if ( groupInput.displayText.trim() == "" ) {
            return
        }

        var selectedGroupType = groupTypeList.model.get(groupTypeList.currentIndex).type

        console.log("groupType:" + selectedGroupType)

        var category = groupCategoryList.model.get(groupCategoryList.currentIndex)

        var newData = {
            rowId: rowId,
            name: groupInput.displayText,
            type:selectedGroupType,
            categoryId: category.rowId,
            categoryName: category.name
        }

        if (updateMode){
            GroupModel.updateGroup(index,newData)
            stackView.pop(StackView.Immediate)
        }else{
            rowId = GroupModel.addGroup(newData)
            stackView.replace("qrc:/qml/MyGroups/ItemFormBulk.qml", {groupId: rowId, name: groupInput.displayText}, StackView.Immediate)
        }

        console.log("new rowId:" + rowId + (typeof rowId))

        groupInput.text = ""
    }

    padding: 16
    Column {
        id:container
        spacing: 20
        anchors.fill: parent
        height: Qt.inputMethod && Qt.inputMethod.visible ? Qt.inputMethod.keyboardRectangle.height / Screen.devicePixelRatio : parent.height



        TextField {
            id: groupInput
            anchors.horizontalCenter:  parent.horizontalCenter

            placeholderText: "Group name"
            text:  name
            width: parent.width * 0.8
            maximumLength: 26
            inputMethodHints: Qt.ImhNoPredictiveText; //workaround for onTextChanged not fired on mobile

            onTextChanged: {
                actionOK.enabled = (text.length > 0) ? true: false
            }


            Keys.onReturnPressed: {
                if (Qt.inputMethod && Qt.inputMethod.visible ){
                    Qt.inputMethod.hide()

                }

                //save()
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
                    currentIndex: 0
                    textRole: "name"
                    model: CategoryModel.categoryModel

                }

                Image {
                    id: newCategoryButton

                    sourceSize.width: parent.height * 0.6
                    sourceSize.height: parent.height* 0.6
                    source: "/assets/edit.svg"

                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.left: groupCategoryList.right

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stackView.push("qrc:/qml/MyGroups/Categories.qml")
                        }
                    }
                }


            }


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
                //anchors.bottom: container.bottom
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
