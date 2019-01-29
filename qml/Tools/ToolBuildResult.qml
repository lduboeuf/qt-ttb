import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolBuildSelect
    title: qsTr("Build Teams result:")

    header:NavigationBar{


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
    property int nbItems: 0

    onSelectedGroupChanged: build()

    function build(){
        console.log(selectedGroup)
        if (selectedGroup.length == 0 ) return //don't do nothing
        var list = ItemModel.findAllitems(selectedGroup)

        var newList = Tools.build(list,nbItems )

        resultList.model.clear()
        for (var i=0; i < newList.length; i++){
            resultList.model.append(newList[i])
        }


    }

    ListView {
        id:resultList
        anchors.fill: parent
        anchors.margins: 16
        anchors.topMargin: 50


        model: ListModel{

        }


        delegate: Text {
            text: name;
            //font.pixelSize: 24
            anchors.left: parent.left
            height: implicitHeight * 2

            anchors.topMargin: 8
            anchors.leftMargin: 4
        }
        focus: true

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Column{
                width: parent.width


                Text {
                    //anchors.left: parent.left
                    font.pixelSize: 16
                    color: "grey"
                    text: section
                }
                Rectangle {
                    width: parent.width
                    color: "lightgrey"
                    height: 1
                }
            }
        }



        ScrollBar.vertical: ScrollBar {}
    }



}
