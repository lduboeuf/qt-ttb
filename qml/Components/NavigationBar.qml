import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.1

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
                sourceSize.width: toolButtonLeft.height * 0.4
                sourceSize.height: toolButtonLeft.height * 0.4
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



            ColorOverlay {
                    id: overlay
                    anchors.fill: parent
                    source: navImage
                    color: Material.foreground
                }
        }
        Column{
            anchors.left: toolButtonLeft.right
            anchors.right: actionsRow.left
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

            }


        }



        Row {
                id: actionsRow

                anchors.right: parent.right
                height: parent.implicitHeight

                Repeater {
                    model: rightActions.length

                    delegate: ToolButton {
                        id: iconAction
                        enabled:  rightActions[index].enabled

                        contentItem: Item{

                            Image {
                                id: rigthActionImg
                                fillMode: Image.Pad
                                sourceSize.width: iconAction.height  * 0.4
                                sourceSize.height: iconAction.height  * 0.4
                                source: rightActions[index].source
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter

                            }
                            ColorOverlay {
                                source: rigthActionImg
                                anchors.fill: rigthActionImg
                                color: Material.foreground
                            }
                        }

                       onClicked: rightActions[index].onTriggered()
                    }
                }


    }

}

}
