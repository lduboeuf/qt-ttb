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


    GridLayout {
            anchors.fill: parent
            anchors.margins: 20
            rowSpacing: 20
            columnSpacing: 20
            rows: width > height ? 1: 2
            columns: width > height ? 4: 2
            //flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

            RoundButton{
                Layout.fillWidth: true
                implicitHeight: width
                implicitWidth: width
                radius: width/2
                text: qsTr("Build Teams")
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.push("qrc:/qml/Tools/ToolBuild.qml")
                }
            }

            RoundButton{
                Layout.fillWidth: true
                implicitHeight: width
                implicitWidth: width


                radius: width/2
                text: qsTr("Find members")
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.push("qrc:/qml/Tools/ToolFind.qml")
                }

            }

            RoundButton{
                Layout.fillWidth: true
                implicitHeight: width
                implicitWidth: width
                radius: width/2
                text: qsTr("Who's next")
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.push("qrc:/qml/Tools/ToolNext.qml")
                }

            }

            RoundButton{
                Layout.fillWidth: true
                implicitHeight: width
                implicitWidth: width
                radius: width/2
                text: qsTr("Find pairs")
                Layout.alignment: Qt.AlignHCenter
                enabled: false


            }


        }




}
