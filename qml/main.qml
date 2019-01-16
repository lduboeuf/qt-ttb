import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0


ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 520

    title: qsTr("Kikou ttb")

    Settings {
            id: settings
            property string style: "Suru"
        }


    header: ToolBar {
        //anchors.fill: parent

        LinearGradient {
            anchors.fill:parent

            start: Qt.point(0, 0)
            end: Qt.point(parent.width, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 1.0; color: "#5676b3" }
            }
        }

        ToolButton {
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: stackView.depth > 1 ? "../assets/back.png" : "../assets/drawer.png"
            }
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                    menuList.currentIndex = -1
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            id: titleLabel
            text: stackView.currentItem ? stackView.currentItem.title : "TTB"
            font.pixelSize: 20
            elide: Label.ElideRight
            anchors.fill: parent
            //anchors.left: parent.left
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }


    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height


        ListView {
            id: menuList
            focus: true
            currentIndex: -1
            anchors.fill: parent

            header:
                RowLayout{
                id:menuHeader
                width:drawer.width
                height: window.height * 0.10
                LinearGradient {
                    anchors.fill:parent

                    start: Qt.point(0, 0)
                    end: Qt.point(drawer.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 1.0; color: "#5676b3" }
                    }
                }

                Image{
                    anchors.top: parent.top
                    anchors.margins: 4
                    anchors.left: parent.left
                    source:"../assets/icon.png"

                    sourceSize.width: menuHeader.height* 0.8
                    sourceSize.height: menuHeader.height* 0.8
                }

            }

            delegate: Component{
                Item{
                    width:drawer.width
                    height:40

                    Row{
                        id: menuItem
                        spacing: 16
                        anchors.margins: 16
                        anchors.fill: parent

                        Text {
                            opacity: 0.87
                            font.pixelSize: Qt.application.font.pixelSize * 1.2
                            font.family: customFont.name
                            text: model.icon
                            //Layout.fillWidth: true
                            font.weight: Font.Medium
                            anchors.verticalCenter: parent.verticalCenter

                        }

                        Item {
                            width: 4
                        }

                        Text {
                            opacity: 0.87
                            font.pixelSize: Qt.application.font.pixelSize * 1.2
                            text: model.title
                            //Layout.fillWidth: true
                            font.weight: Font.Medium
                            anchors.verticalCenter: parent.verticalCenter
                        }


                    }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: {
                            menuList.currentIndex = index
                            stackView.push(model.source)
                            drawer.close()
                        }

                    }
                }
            }


            model: ListModel {
                ListElement { title: qsTr("Page 1"); source: "qrc:/qml/Page1Form.ui.qml"; icon:"\ue972" }
                ListElement { title: qsTr("Page 2"); source: "qrc:/qml/Page2Form.qml"; icon:"\uea09" }
                ListElement { title: qsTr("Spinbox"); source: "qrc:/qml/SpinBoxTest.qml"; icon:"\uea09" }
            }
        }
    }


    StackView {
        id: stackView
        initialItem: "qrc:/qml/HomeForm.ui.qml"
        anchors.fill: parent
    }

    FontLoader { id: customFont; source: "../assets/icomoon.ttf" }
}
