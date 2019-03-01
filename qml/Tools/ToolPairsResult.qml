import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolPairs
    title: qsTr("Find pairs")

    header:NavigationBar{
        subtitle: qsTr("Result")


        rightActions:[
            Action{
              id:actionSave
              source: "/assets/save.svg"
              onTriggered: function(){
                archiveDialog.open()
              }

            },
            Action{
                id: actionReload
                source: "/assets/reload.svg"
                onTriggered: function(){
                    build()
                }

            }

        ]
    }

    property var itemsLeft
    property var itemsRight

    property var resultItems


    Component.onCompleted: {
        build()
    }


    function build(){

        resultItems = Tools.pairs(itemsLeft,itemsRight )
        //build view
        model.clear()
        for (var i=0; i < resultItems.length; i++){
            model.append(resultItems[i])
        }
    }


    ListView {
        id:resultList
        anchors.fill: parent
        anchors.margins: 2
        anchors.topMargin: 20


        model: ListModel{
            id:model
        }
        delegate:SwipableItem{

            iconSource : ""
            swipe.right: null
            swipe.left: null

        }

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Text {
                topPadding: 16
                text: section
                color:Material.foreground
                opacity: 0.6



                Rectangle {
                    color: "lightgrey"
                    width: resultList.width
                    anchors.top: parent.bottom
                    height: 1

                }
            }
        }

        ScrollBar.vertical: ScrollBar {}

    }

    ArchiveDialog{
        id: archiveDialog
        typeName: toolPairs.title.toString()
        toSave: resultItems
        actionButton: actionSave

    }

}
