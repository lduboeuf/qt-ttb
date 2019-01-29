import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Components"
import "../Model"




Page {
    id: categoryPage

    title: qsTr("My Groups")

     header:NavigationBar{

            rightActions:[
                Action{
                    source: "/assets/add.svg"
                    onTriggered: function(){
                        stackView.push("qrc:/qml/MyGroups/CategoryForm.qml")
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
                    CategoryModel.remove(index)
                }

                onEditClicked: function(index){
                    var data = categoryList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/CategoryForm.qml", {index: index, rowId: data.rowId, name:data.name})
                    swipe.close()
                }

                onItemClicked: function(index){
                    var data = categoryList.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/CategoryForm.qml", {categoryId: data.rowId, name:data.name})
                }
            }
        }

    }
}
