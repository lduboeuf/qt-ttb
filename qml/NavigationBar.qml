import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

//    Component.onCompleted: {
//           window.header = header
//     }



ToolBar {
    id:mainToolBar
    property alias toolbarButtons: buttonsLoader.sourceComponent


    RowLayout {
        anchors.fill: parent

        ToolButton {
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                sourceSize.width: parent.height * 0.4
                sourceSize.height: sourceSize.height
                source: stackView.depth > 1 ? "../assets/go-previous.svg" : "../assets/navigation-menu.svg"
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
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }
        Loader {
            Layout.alignment: Qt.AlignRight
            id: buttonsLoader
        }


    }

}

