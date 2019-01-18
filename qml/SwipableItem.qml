import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0


SwipeDelegate {
    id: swipeDelegate
    width: parent.width

    contentItem:

        Text{
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        //font.pixelSize: Qt.application.font.pixelSize * 1.2
        //anchors.left: parent.left
        text: name

        Image {
            anchors.right: parent.right
            //fillMode: Image.Pad
            //horizontalAlignment: Image.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: swipeDelegate.height - (swipeDelegate.height * 0.4)
            sourceSize.height: sourceSize.height
            source: "../assets/next.svg"

        }
    }

    property var onRemoveClicked
    property var onEditClicked


swipe.left: Rectangle {
    color: SwipeDelegate.pressed ? Qt.darker("red", 1.1) : "red"
    //width: parent.width
    anchors.left: parent.left
    width: parent.width - (parent.width*0.6)
    height: parent.height
    clip: true


    //SwipeDelegate.onClicked: view.model.remove(ourIndex)

    Image {
        id: deleteImg

        anchors.centerIn: parent
        sourceSize.width: parent.height * 0.3
        sourceSize.height: sourceSize.height
        source: "../assets/edit-delete.svg"
    }
    ColorOverlay {
        anchors.fill: deleteImg
        source: deleteImg
        color: "white"  // make image like it lays under red glass
    }

    MouseArea { //workaround for mobile
        anchors.fill: parent
        onClicked: onRemoveClicked(index)
    }
}



    swipe.right: Rectangle {
        color: SwipeDelegate.pressed ? Qt.darker("green", 1.1) : "green"
        anchors.right: parent.right
        width: parent.width * 0.3
        height: parent.height
        clip: true


        //SwipeDelegate.onClicked: view.model.remove(ourIndex)

        Image {
            id: editImg

            anchors.centerIn: parent
            sourceSize.width: parent.height - (parent.height * 0.6)
            sourceSize.height: sourceSize.height
            source: "../assets/edit.svg"
        }
        ColorOverlay {
            anchors.fill: editImg
            source: editImg
            color: "white"  // make image like it lays under red glass
        }

        MouseArea { //workaround for mobile
            anchors.fill: parent
            onClicked: onEditClicked(index)
        }
    }

}
