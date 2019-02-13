import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolBuildSelect
    title: qsTr("Build Teams")

    header:NavigationBar{
        subtitle: qsTr("Result")


        rightActions:[
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

        resultItems = Tools.build(list,nbItems )

        setModel()
    }

    function removeItem(index){

        resultItems.splice(index, 1)
        resultItems = Tools.build(resultItems,nbItems )

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
            swipe.right: null

            onRemoveClicked: function(index){
                toolBuildSelect.removeItem(index)
            }
        }

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Text {
                topPadding: 16
                color:Material.foreground
                opacity: 0.6
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






}
