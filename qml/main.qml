import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.0
import "./Database.js" as DB

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 520

    title: qsTr("Kikou ttb")



    //property var db: LocalStorage.openDatabaseSync("ttb", "1.0", "The Example QML SQL!", 1000000)


    Settings {
        id: settings
        property string style: "Suru"
    }

    //header: NavigationBar{}

   // property alias actionButtons: buttonsLoader.sourceComponent

//    header: ToolBar {
//        id:mainToolBar
//        Material.foreground: "white"



//        RowLayout {
//            anchors.fill: parent

//            ToolButton {
//                contentItem: Image {
//                    fillMode: Image.Pad
//                    horizontalAlignment: Image.AlignHCenter
//                    verticalAlignment: Image.AlignVCenter
//                    source: stackView.depth > 1 ? "../assets/back.png" : "../assets/drawer.png"
//                }
//                onClicked: {
//                    if (stackView.depth > 1) {
//                        stackView.pop()
//                        menuList.currentIndex = -1
//                    } else {
//                        drawer.open()
//                    }
//                }
//            }

//            Label {
//                id: titleLabel
//                text: stackView.currentItem ? stackView.currentItem.title : qsTr("Team Toolbox")
//                font.pixelSize: 20
//                elide: Label.ElideRight
//                //anchors.fill: parent
//                anchors.left: parent.left
//                anchors.right: parent.right
//                horizontalAlignment: Qt.AlignHCenter
//                verticalAlignment: Qt.AlignVCenter
//                Layout.fillWidth: true
//            }
//            Loader {
//                Layout.alignment: Qt.AlignRight
//                id: buttonsLoader
//            }

////            ToolButton {
////               id: addActionBar
////               anchors.right: parent.right

////               font.family: customFont.name
////               text: "\uea0a"
////               visible: false
////            }


//        }

//    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height


        ListView {
            id: menuList
            focus: true
            currentIndex: -1
            anchors.fill: parent
            //spacing:5

            header:
                RowLayout{
                id:menuHeader
                width:drawer.width
                height: stackView.currentItem.header.height

                LinearGradient {
                    anchors.fill:parent

                    start: Qt.point(0, 0)
                    end: Qt.point(drawer.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 1.0; color: "#5676b3" }
                    }
                }

//                Image{
//                    anchors.top: parent.top
//                    anchors.margins: 4
//                    //anchors.left: 16
//                    source:"../assets/icon.png"

//                    sourceSize.width: menuHeader.height* 0.8
//                    sourceSize.height: menuHeader.height* 0.8
//                }

            }

            delegate: Component{
                ItemDelegate{
                    width:drawer.width
                    //height:50
                    //spacing: 16
                    highlighted: ListView.isCurrentItem ? true : false

                    onClicked: {
                        menuList.currentIndex = index
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
                           sourceSize.width: parent.height * 0.4
                           sourceSize.height: sourceSize.height
                           source: model.iconsource
                       }

//                        Text {
//                            id:menuIcon
//                            opacity: 0.60
//                            //font.pixelSize: Qt.application.font.pixelSize * 1.2
//                            font.family: customFont.name
//                            text: model.icon
//                            verticalAlignment: Text.AlignVCenter
//                            anchors.verticalCenter: parent.verticalCenter

//                            //anchors.baseline: parent.bottom

//                        }


                        Text {
                            opacity: 0.60
                            //font.pixelSize: Qt.application.font.pixelSize * 1.2
                            font.family: customFont.name
                            text: model.title
                            anchors.left: parent.left
                            anchors.bottom:  menuIcon.bottom
                            anchors.leftMargin: 36
                            //verticalAlignment: Text.AlignVCenter
                            //anchors.verticalCenter: parent.verticalCenter
                        }


                    }

                }
            }


            model: ListModel {
                ListElement { title: qsTr("Home"); source: "qrc:/qml/ToolsTab.qml"; iconsource:"../assets/home.svg" }
                ListElement { title: qsTr("My Groups"); source: "qrc:/qml/Groups.qml"; iconsource:"../assets/contact-group.svg" }
                ListElement { title: qsTr("About"); source: "qrc:/qml/About.qml"; iconsource:"../assets/info.svg" }
                //ListElement { title: qsTr("Spinbox"); source: "qrc:/qml/SpinBoxTest.qml"; iconsource:"\uea09" }
            }
        }
    }



    StackView {
        id: stackView
        initialItem: "qrc:/qml/ToolsTab.qml"
        anchors.fill: parent
    }

    //FontLoader { id: customFont; source: "../assets/icomoon.ttf" }

    Component.onCompleted: {
            DB.dbInit()
        }
}
