import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "../Components"
import "../Model"

Page {
    id: categoryForm

    property int index: 0
    property int categoryId:0
    property int rowId:0
    property string name:""

    property bool updateMode: name.length===0 ? false: true

    title: name

    //onCategoryIdChanged: filterGroupList()


    function filterGroupList(){
        groupModel.clear()
        for (var i=0; i < GroupModel.groupModel.count; i++){
            var row = GroupModel.groupModel.get(i)

            if (row.categoryId === categoryId){
                groupModel.append(row)

            }
        }
    }


    header:NavigationBar{

        subtitle: updateMode ? qsTr("Edit Category"): qsTr("Add Category")


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
        if ( categoryInput.displayText.trim() == "" ) {
            return
        }

        if (updateMode){
            CategoryModel.update(index, rowId, categoryInput.displayText)
        }else{
            CategoryModel.add(categoryInput.displayText)
        }

        categoryInput.text = ""
        stackView.pop()
    }

    Column {
            spacing: 40
            anchors.margins:16
            anchors.fill: parent

        TextField {
            id: categoryInput
            width: parent.width * 0.8
            maximumLength: 26
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Category name"
            text:  name
            inputMethodHints: Qt.ImhNoPredictiveText; //workaround for onTextChanged not fired on mobile

            //width: parent.width -this.height

            Keys.onReturnPressed: {
                save()
            }

            onDisplayTextChanged: {
                actionOK.enabled = (text.length > 0) ? true: false
            }

        }

        Label{

            text: qsTr("Groups:")
        }


        ListView {
            id: groupList
             width: parent.width
             height: parent.height
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: ListModel{
                id: groupModel

            }

            delegate: SwipableItem{

               iconSource : GroupModel.getImageSource(model.type)

                onRemoveClicked: function(index){
                    GroupModel.removeGroup(index)
                }

                onEditClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/GroupForm.qml", {index: index, rowId: data.rowId, name:data.name, currentType:data.type, currentCategoryId: data.categoryId})
                    swipe.close()
                }

                onItemClicked: function(index){
                    var data = groupList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/Items.qml", {groupId: data.rowId, groupName:data.name})
                }
            }

        }
    }
    StackView.onActivated: {

        categoryInput.forceActiveFocus()
        filterGroupList() //refresh view

    }

}
