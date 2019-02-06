import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Components"
import "../Model"




Page {
    id: categoryPage

    title: qsTr("Categories")

     header:NavigationBar{

            rightActions:[
                Action{
                    source: "/assets/add.svg"
                    onTriggered: function(){
                        stackView.push("qrc:/qml/MyGroups/CategoryForm.qml", StackView.Immediate)
                    }

                }
            ]

     }


    Column {
        spacing: 40
       // width: parent.width
        anchors.fill: parent

        ListView {
            id: categoryList
             width: parent.width
             height: parent.height
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: CategoryModel.categoryModel

            delegate: SwipableItem{

               iconSource : ""

                onRemoveClicked: function(index){
                    categoryList.currentIndex = index
                    confirmationDialog.open()
                    //CategoryModel.remove(index)
                }

                onEditClicked: function(index){
                    var data = categoryList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/CategoryForm.qml", {index: index, rowId: data.rowId, name:data.name}, StackView.Immediate)
                    swipe.close()
                }

                onItemClicked: function(index){
                    var data = categoryList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/CategoryForm.qml", {categoryId: data.rowId, name:data.name}, StackView.Immediate)
                }
            }
        }

    }

    Dialog {
        id: confirmationDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column {
            spacing: 20
            anchors.fill: parent
            Label {
                text: qsTr("This category contains groups and items, are you sure you want to remove it?")
            }

        }

        onAccepted: {

            confirmationDialog.close()
            CategoryModel.remove(categoryList.currentIndex)

        }
    }
}
