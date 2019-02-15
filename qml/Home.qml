import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1


import "Components"

Page {
    id: settingsPage


    title: qsTr('Team Toolbox')


    header:NavigationBar{

        id: navBar

        rightActions:[
            Action{
                id: themeSwitching
                color: Material.background
                source: (settings.theme===Material.Light) ? "/assets/torch-on.svg" : "/assets/torch-off.svg"
                onTriggered: function(){
                    if (settings.theme===Material.Light){
                        settings.theme = Material.Dark
                    }else{
                        settings.theme = Material.Light
                    }

                 }

            }
        ]



    }

    ListModel {
       id:toolsModel
      ListElement { title: qsTr("Build Teams"); source: "qrc:/qml/Tools/ToolBuild.qml" }
      ListElement { title: qsTr("Find members"); source: "qrc:/qml/Tools/ToolFind.qml" }
      ListElement { title: qsTr("Who's next"); source: "qrc:/qml/Tools/ToolNext.qml" }
      ListElement { title: qsTr("Find pairs"); source: ""}
      //ListElement { title: qsTr("Build Teams"); source: "qrc:/qml/Tools/ToolBuild.qml" }
    }

    Component{
        id:buttonDelegate
        RoundButton{
            Layout.fillWidth: true
            implicitHeight: width
            implicitWidth: width
            enabled: (source.length > 0)
            radius: width/2
            text: title
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                stackView.push(source)
            }
        }
    }


    GridLayout {
            anchors.fill: parent
            anchors.margins: 20
            rowSpacing: 20
            columnSpacing: 20
            rows: width > height ? 1: 2
            columns: width > height ? 4: 2
            //flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom


            Repeater{
                model: toolsModel
                delegate: buttonDelegate

            }



        }




}
