import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

//    Component.onCompleted: {
//           window.header = header
//     }



ToolBar {
    id:mainToolBar

    property alias leftAction:toolButtonLeft
    property alias subtitle: subTitleLabel.text
    property list<Action> rightActions


    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: toolButtonLeft
            visible: (contentItem!==null)

            contentItem: Image {
                id:navImage
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                sourceSize.width: parent.height * 0.6
                sourceSize.height: parent.height * 0.4
                source: stackView.depth > 1 ? "/assets/go-previous.svg" : "/assets/navigation-menu.svg"
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
        Column{
            anchors.left: toolButtonLeft.right
            anchors.right: actionsRow.left
            //anchors.margins: actionsRow.width
            Label {
                id: titleLabel
                text: stackView.currentItem ? stackView.currentItem.title : qsTr("Team Toolbox")
                font.pixelSize: 20
                elide: Label.ElideRight
            }

            Label {
                id: subTitleLabel
                font.pixelSize: 12
                elide: Label.ElideRight

               // horizontalAlignment: Text.AlignHCenter

            }


        }



        Row {
                id: actionsRow

                anchors {
                    right: parent.right
                }

                height: parent.implicitHeight


                Repeater {
                    model: rightActions.length

                    delegate: ToolButton {
                        id: iconAction

                        //objectName: "action/" + action.objectName
                        enabled:  rightActions[index].enabled

                        contentItem: Image {
                           fillMode: Image.Pad
                           horizontalAlignment: Image.AlignHCenter
                           verticalAlignment: Image.AlignVCenter
                           sourceSize.width: parent.height  * 0.4
                           sourceSize.height: sourceSize.height
                           source: rightActions[index].source
                       }

                       onClicked: rightActions[index].onTriggered()



                        anchors.verticalCenter: parent ? parent.verticalCenter : undefined
                    }
                }


    }

}

}
