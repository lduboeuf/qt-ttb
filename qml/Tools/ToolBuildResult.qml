import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
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

            RowLayout {
            //width: parent.width
            width: parent.width
            height: txtLeft.height * 2
            anchors.margins: 16
            //height: implicitHeight * 2

           spacing: 16


            Text {
                id:txtLeft
                text: name;
                //font.pixelSize: 24
                //anchors.left: parent.left
                //opacity: 0.60
                //font.pixelSize: Qt.application.font.pixelSize * 1.2
                anchors.leftMargin: 2
            }
            Image {
                id: iconRight
                anchors.rightMargin:  16
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                sourceSize.height: txtLeft.height
                sourceSize.width:txtLeft.height
                source: "/assets/close.svg"

            }

            MouseArea { //workaround for mobile
                anchors.fill: iconRight
                onClicked: toolBuildSelect.removeItem(index)
            }

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
