import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
Page {
    property alias toolbarButtons: buttonsLoader.sourceComponent

//    Component.onCompleted: {
//           window.header = header
//     }

    header:ToolBar {
            id:mainToolBar

            RowLayout {
                //anchors.fill: parent
                width:parent.width

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
                    text: stackView.currentItem ? stackView.currentItem.title : qsTr("Team Toolbox")
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    //anchors.fill: parent
                    //anchors.left: parent.left
                    //anchors.right: parent.right
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
                Loader {
                    Layout.alignment: Qt.AlignRight
                    //anchors.right: parent.right
                    id: buttonsLoader
                }


            }

        }

}
