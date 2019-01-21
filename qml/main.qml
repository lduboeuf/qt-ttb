import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "qrc:/qml/Model" //import "Model" doesn't work here



ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 520

    title: qsTr("Team Toolbox")

 //   property var groupList


//    Settings {
//        id: settings
//        //property string style: getStyle()
//    }

//    function getStyle(){
//        var style = "System";
//        console.log("os:" + Qt.platform.os)
//        if (Qt.platform.os == "android"){
//            style = "Material"
//        } else if (Qt.platform.os == "linux"){
//            style = "Suru"
//        }
//        return style
//    }



    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        property int headerHeight: window.height * 0.15


        ListView {
            id: menuList
            focus: true
            currentIndex: -1
            anchors.fill: parent

            header:
                RowLayout{
                id:menuHeader
                width:drawer.width
                height: drawer.headerHeight

                LinearGradient {
                    anchors.fill:parent

                    start: Qt.point(0, 0)
                    end: Qt.point(drawer.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 1.0; color: "#5676b3" }
                    }
                }


            }

            delegate: Component{
                ItemDelegate{
                    width:drawer.width
                    highlighted: ListView.isCurrentItem ? true : false

                    onClicked: {
                        menuList.currentIndex = index
                        stackView.clear()
                        stackView.push(model.source)
                        drawer.close()
                    }

                    contentItem:

                    RowLayout{
                        id: menuItem

                        anchors.leftMargin: 16
                        anchors.fill: parent

                        Image {
                           id:menuIcon
                           fillMode: Image.Pad
                           horizontalAlignment: Image.AlignHCenter
                           verticalAlignment: Image.AlignVCenter
                           sourceSize.width: menuLabel.height
                           sourceSize.height: menuLabel.height
                           source: model.iconsource
                       }


                        Text {
                            id:menuLabel
                            opacity: 0.60
                            text: model.title
                            anchors.left: parent.left
                            anchors.bottom:  menuIcon.bottom
                            anchors.leftMargin: 36
                        }


                    }

                }
            }


            model: ListModel {
                ListElement { title: qsTr("Home"); source: "qrc:/qml/Tools/ToolsTab.qml"; iconsource:"../assets/home.svg" }
                ListElement { title: qsTr("My Groups"); source: "qrc:/qml/MyGroups/Groups.qml"; iconsource:"../assets/groups.svg" }
                ListElement { title: qsTr("About"); source: "qrc:/qml/About.qml"; iconsource:"../assets/info.svg" }
                //ListElement { title: qsTr("Spinbox"); source: "qrc:/qml/SpinBoxTest.qml"; iconsource:"\uea09" }
            }
        }
    }



    StackView {
        id: stackView
        initialItem: "qrc:/qml/Tools/ToolsTab.qml"
        anchors.fill: parent
    }

    Component.onCompleted: {
        drawer.headerHeight = stackView.currentItem.header.height
           if (GroupModel.groupModel.rowCount()===0){
               console.log("WelcomePage")
           }
    }
}
