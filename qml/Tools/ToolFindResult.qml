import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolFindSelect
    title: qsTr("Find Members")

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
                id: actionOK
                source: "/assets/reload.svg"
                onTriggered: function(){
                    shuffle()
                }

            }
        ]
    }

    property var selectedGroup: []
    property var resultItems : []
    property int nbItems: 0
    property var initialList

    onSelectedGroupChanged: build()


    function build(){
        console.log(selectedGroup)
        if (selectedGroup.length == 0 ) return //don't do nothing
        initialList = ItemModel.findAllitems(selectedGroup)

        shuffle()
    }

    function removeItem(index){
        var row = resultItems[index]
        //remove from the main list
        for (var i=0; i < initialList.length;i++){
            if (initialList[i].rowId === row.rowId ){
                initialList.splice(i, 1)
                break
            }
        }

        shuffle()
    }

    function shuffle(){
        resultItems = Tools.find(initialList,nbItems )
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

            onRemoveClicked: function(index){
                toolFindSelect.removeItem(index)
            }

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
        typeName: toolFindSelect.title.toString()
        toSave: resultItems
        actionButton: actionSave

    }

}
