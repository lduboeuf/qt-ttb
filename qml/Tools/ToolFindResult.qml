import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolBuildSelect
    title: qsTr("Find Members")

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
    property var list

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
        list = ItemModel.findAllitems(selectedGroup)

        resultItems = Tools.find(list,nbItems )

        setModel()
    }

    function removeItem(index){

        var row = resultItems[index]
        //remove from the main list
        for (var i=0; i < list.length;i++){
            if (list[i].rowId === row.rowId ){
                list.splice(i, 1)
                break
            }
        }

        resultItems = Tools.find(list,nbItems )

        setModel()


    }

    ListView {
        id:resultList
        anchors.fill: parent
        anchors.margins: 2
        anchors.topMargin: 20


        model: ListModel{

        }
        delegate:SwipableItem{

            iconSource : ""
            swipe.right: null

             onRemoveClicked: function(index){
                 toolBuildSelect.removeItem(index)
             }



            //            Image {
            //                id: iconRight
            //                anchors.rightMargin:  16
            //                anchors.right: parent.right
            //                anchors.verticalCenter: parent.verticalCenter

            //                sourceSize.height: txtLeft.height
            //                sourceSize.width:txtLeft.height
            //                source: "/assets/close.svg"

            //            }

            //            MouseArea { //workaround for mobile
            //                anchors.fill: iconRight
            //                onClicked: toolBuildSelect.removeItem(index)
            //            }

        }
        //focus: true

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Text {
                //anchors.horizontalCenter: parent.horizontalCenter
                //font.pixelSize: 16
                topPadding: 16
                //font.bold: true
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






}
