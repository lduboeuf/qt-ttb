import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Model"
import "../Components"

import "./tools.js" as Tools



Page {
    id: toolBuildSelect
    title: qsTr("Build Teams result:")

    header:NavigationBar{
        toolbarButtons: ToolButton {
            id: addActionBar
            anchors.right: parent.right
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                sourceSize.width: parent.height  * 0.4
                sourceSize.height: sourceSize.height
                source: "/assets/reload.svg"
            }

            onClicked: {
                build()
            }
        }
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

            model: ListModel{

            }


            delegate: Text {
                text: name;
                font.pixelSize: 24
                anchors.left: parent.left
                anchors.leftMargin: 2
            }
            focus: true

            section {
                property: "groupName"
                criteria: ViewSection.FullString
                delegate: Rectangle {
                    color: "#b0dfb0"
                    width: parent.width
                    height: childrenRect.height + 4
                    Text { anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 16
                        font.bold: true
                        text: section
                    }
                }
            }


            ScrollBar.vertical: ScrollBar {}
        }



}
