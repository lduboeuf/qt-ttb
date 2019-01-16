import QtQuick 2.0
import QtQuick.Controls 2.2


SwipeDelegate {
    id: swipeDelegate
    text: model.name

    ListView.onRemove: SequentialAnimation {


        PropertyAction {
            target: swipeDelegate
            property: "ListView.delayRemove"
            value: true
        }
        NumberAnimation {
            target: swipeDelegate
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: swipeDelegate;
            property: "ListView.delayRemove";
            value: false
        }
    }

    swipe.left: Label {
        id: deleteLabel
        font.family: customFont.name
        text: "\ue9ac"
        color: "white"
        verticalAlignment: Label.AlignVCenter
        padding: 50
        height: parent.height
        anchors.left: parent.left

        SwipeDelegate.onClicked: console.log("kikou delete")

        background: Rectangle {
            color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("red", 1.1) : "red"
        }
    }

    swipe.right: Label {
        id: editLabel
        font.family: customFont.name
        text: "\ue905"
        color: "white"
        verticalAlignment: Label.AlignVCenter
        padding: 50
        height: parent.height
        anchors.right: parent.right

        SwipeDelegate.onClicked: console.log("kikou edit")

        background: Rectangle {
            color: editLabel.SwipeDelegate.pressed ? Qt.lighter("green", 1.1) : "green"
        }
    }
}
