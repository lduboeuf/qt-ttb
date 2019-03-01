import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolNextResult
    title: qsTr("Who's next")

    header:NavigationBar{
        subtitle: qsTr("Result")

        returnHome: true;


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
                    build()
                }

            }
        ]
    }

    property var selectedGroup: []
    property var resultItems : []
    property int nbItems: 0

    onSelectedGroupChanged: build()

    function setModel(){
        resultList.model.clear()
        for (var i=0; i < resultItems.length; i++){
            resultList.model.append(resultItems[i])
        }
    }


    function build(){
        console.log(selectedGroup)
        if (selectedGroup.length == 0 ) return //don't do nothing
        var list = (resultItems.length!=0) ? resultItems : ItemModel.findAllitems(selectedGroup)

        resultItems = Tools.next(list)

        setModel()
    }

    function removeItem(index){

        resultItems.splice(index, 1)
        resultItems = Tools.next(resultItems)

        setModel()


    }

    ListView {
        id:resultList
        anchors.fill: parent
        anchors.margins: 16
        anchors.topMargin: 20


        model: ListModel{

        }
        delegate:

            SwipableItem{

            iconSource : ""
            indexLabelVisible: true
            swipe.right: null

            onRemoveClicked: function(index){
                toolNextResult.removeItem(index)
            }
        }

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Text {
                //anchors.horizontalCenter: parent.horizontalCenter
                //font.pixelSize: 16
                topPadding: 16
                //leftPadding: 4
                color:Material.foreground
                opacity: 0.6
                //font.bold: true
                text: section


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
        typeName: toolNextResult.title.toString()
        toSave: resultItems
        actionButton: actionSave

    }




}
