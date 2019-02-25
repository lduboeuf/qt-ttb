import QtQuick 2.0

/**
  this is to simulate Action Type qml of QtQuick Control 2.3
**/


QtObject {
        id: action
        property string source: ""
        property color color: "white"
        property var onTriggered: console.log("triggered")
        property bool enabled: true
        property string tooltipText: ""
    }


