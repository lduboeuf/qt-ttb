import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "../Components"
import "../Model"




Page {
    id: categoryPage

    title: qsTr("Archives")

     header:NavigationBar{

     }


    Column {
        spacing: 40
       // width: parent.width
        anchors.fill: parent

        ListView {
            id: list
             width: parent.width
             height: parent.height
            ScrollBar.vertical: ScrollBar {
                active: true
            }

            model: ArchiveModel.itemModel

            delegate: SwipableItem{

                swipe.right: null
                 onRemoveClicked: function(index){
                     list.currentIndex = index
                     confirmationDialog.open()
                     swipe.close()
                 }


                 onItemClicked: function(index){
                    var data = list.model.get(index)
                    stackView.push("qrc:/qml/MyGroups/ArchiveDetail.qml", {archiveId: data.rowId}, StackView.Immediate)
                 }
             }

            section {
                property: "type"
                criteria: ViewSection.FullString
                delegate: Text {
                    text: section
                    opacity: 0.60
                    padding: 8
                    color:Material.foreground

                    Rectangle {
                        color: "lightgrey"
                        width: list.width
                        anchors.top: parent.bottom
                        height: 1

                    }
                }
            }
        }

    }

    DeleteConfirmationDialog{
        id: confirmationDialog
        onConfirmed: {
            ArchiveModel.remove(list.currentIndex)
        }


    }


}
