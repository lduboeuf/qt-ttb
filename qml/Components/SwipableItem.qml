import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


SwipeDelegate {
    id: swipeDelegate
    width: parent.width


    signal removeClicked(int index)
    signal editClicked(int index)
    signal itemClicked(int index)


    property string iconSource : ""


    contentItem: RowLayout {
        width: parent.width
        height: parent.height
        spacing: 16

        Image {
            id: iconLeft
            anchors.leftMargin: 16
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: swipeDelegate.height * 0.4
            sourceSize.height: sourceSize.height
            source: iconSource

        }

        Text{
            anchors.left: iconLeft.right
            anchors.leftMargin: 16
            opacity: 0.60
            anchors.verticalCenter: parent.verticalCenter
            //font.pixelSize: Qt.application.font.pixelSize * 1.2
            //anchors.left: parent.left
            text: name
        }
        Image {
            anchors.right: parent.right
            opacity: 0.60
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: swipeDelegate.height * 0.4
            sourceSize.height: sourceSize.height
            source: "/assets/next.svg"

        }

    }

    onClicked: itemClicked(index)




    swipe.left: Rectangle {
        color: SwipeDelegate.pressed ? Qt.darker("red", 1.1) : "red"
        //width: parent.width
        anchors.left: parent.left
        width: parent.width * 0.2
        height: parent.height
        clip: true


        //SwipeDelegate.onClicked: view.model.remove(ourIndex)

        Image {
            id: deleteImg

            anchors.centerIn: parent
            sourceSize.width: parent.height * 0.3
            sourceSize.height: sourceSize.height
            source: "/assets/edit-delete.svg"
        }
        ColorOverlay {
            anchors.fill: deleteImg
            source: deleteImg
            color: "white"  // make image like it lays under red glass
        }

        MouseArea { //workaround for mobile
            anchors.fill: parent
            onClicked: swipeDelegate.removeClicked(index)
        }
    }



    swipe.right: Rectangle {
        color: SwipeDelegate.pressed ? Qt.darker("green", 1.1) : "green"
        anchors.right: parent.right
        width: parent.width * 0.2
        height: parent.height
        clip: true


        //SwipeDelegate.onClicked: view.model.remove(ourIndex)

        Image {
            id: editImg

            anchors.centerIn: parent
            sourceSize.width: parent.height - (parent.height * 0.6)
            sourceSize.height: sourceSize.height
            source: "/assets/edit.svg"
        }
        ColorOverlay {
            anchors.fill: editImg
            source: editImg
            color: "white"  // make image like it lays under red glass
        }

        MouseArea { //workaround for mobile
            anchors.fill: parent
            onClicked: swipeDelegate.editClicked(index)
        }
    }

}
