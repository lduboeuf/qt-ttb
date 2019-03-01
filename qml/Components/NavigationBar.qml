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


    //property int color: Material.color(Material.white)


    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: toolButtonLeft
            visible: (contentItem!==null)

            contentItem: Image {
                id:navImage
                fillMode: Image.Pad
                sourceSize.width: toolButtonLeft.height  * 0.4
                sourceSize.height: toolButtonLeft.height  * 0.4
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
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
                    anchors.fill: navImage
                    source: navImage
                    color: settings.headerColor
                }
        }
        Column{
            anchors.left: toolButtonLeft.right
            anchors.right: actionsRow.left

            Label {
                id: titleLabel
                text: stackView.currentItem ? stackView.currentItem.title : qsTr("Team Toolbox")
                font.pixelSize: 20
                width: mainToolBar.width - (actionsRow.width + toolButtonLeft.width)
                //maximumLineCount: 1
                elide: Label.ElideRight
                color: settings.headerColor


            }

            Label {
                id: subTitleLabel
                font.pixelSize: 12
                elide: Label.ElideRight
                color: settings.headerColor
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
                        ToolTip.text:rightActions[index].tooltipText
                        ToolTip.visible:rightActions[index].tooltipText.length > 0
                        ToolTip.timeout: 2000

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
                                color: settings.headerColor
                            }
                        }

                       onClicked: rightActions[index].onTriggered()
                    }
                }


    }

}

}
