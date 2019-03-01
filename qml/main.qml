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

    //Material.theme: themeSwitch.checked ? Material.Dark : Material.Light
    Material.theme: settings.theme


 //   property var groupList


    Settings {
        id: settings
        property int theme: Material.theme
        property color headerColor: "#F7F7F7"
    }

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
        width: Math.min(window.width, window.height) * 0.5
        height: window.height
        dragMargin: 0

        //property int headerHeight: window.height * 0.15

        ListView {
            id: menuList
            focus: true
            currentIndex: -1
            anchors.fill: parent

            header: RowLayout{
                id:menuHeader
                width:drawer.width
                height: (stackView.currentItem !== null) ? stackView.currentItem.header.height : window.height * 0.1


                LinearGradient {
                    anchors.fill:parent

                    start: Qt.point(0, 0)
                    end: Qt.point(drawer.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.lighter(Material.primary, 2) }
                        GradientStop { position: 1.0; color: Material.primary }
                    }
                }


            }

            delegate: Component{
                ItemDelegate{
                    width:drawer.width
                    highlighted: ListView.isCurrentItem ? true : false

                    onClicked: {
                        menuList.currentIndex = index
                        if (model.source === stackView.initialItem){
                            stackView.clear()
                        }
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
                            opacity: 0.80
                            text: model.title
                            anchors.left: parent.left
                            anchors.bottom:  menuIcon.bottom
                            anchors.leftMargin: 36
                            color: Material.foreground
                        }


                    }

                }
            }


            model: ListModel {
                ListElement { title: qsTr("Home"); source: "qrc:/qml/Home.qml"; iconsource:"../assets/home.svg" }
                ListElement { title: qsTr("My Groups"); source: "qrc:/qml/MyGroups/Groups.qml"; iconsource:"../assets/groups.svg" }
                ListElement { title: qsTr("Categories"); source: "qrc:/qml/MyGroups/Categories.qml"; iconsource:"../assets/groups.svg" }
                ListElement { title: qsTr("Archives"); source: "qrc:/qml/MyGroups/Archives.qml"; iconsource:"../assets/archive.svg" }

                ListElement { title: qsTr("Settings"); source: "qrc:/qml/Settings.qml"; iconsource:"../assets/settings.svg" }
                ListElement { title: qsTr("About"); source: "qrc:/qml/About.qml"; iconsource:"../assets/info.svg" }
                //ListElement { title: qsTr("Spinbox"); source: "qrc:/qml/SpinBoxTest.qml"; iconsource:"\uea09" }
            }
        }
    }



    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/qml/Home.qml"
        //initialItem: "qrc:/qml/MyGroups/GroupForm.qml"

    }

    Component.onCompleted: {
        console.log("main.qml loaded")
       // drawer.headerHeight =  (stackView.currentItem.header !== null) ? stackView.currentItem.header.height : window.height * 0.1

        if (GroupModel.groupModel.rowCount()===0) {

            stackView.push("qrc:/qml/WelcomePage.qml",{},StackView.Immediate)
        }

        console.log(Qt.application.version)


    }

}
