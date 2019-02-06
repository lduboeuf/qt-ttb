import QtQuick 2.9
import QtQuick.Controls 2.2
import "Components"

ScrollablePage{

    //topPadding: 16
    title: qsTr("About")

    header:NavigationBar{}

    Column {
        id: column
        spacing: 40
        anchors.margins: 16
        anchors.fill: parent

        Image {
           id:logo
           fillMode: Image.Pad
           anchors.horizontalCenter: parent.horizontalCenter
           sourceSize.width: parent.width * 0.3
           //sourceSize.height: parent.height * 0.3
           source: "/assets/icon.png"
       }



        Text{
            id:content
            anchors.margins: 16
            width: parent.width
            font.pixelSize: Qt.application.font.pixelSize * 1.1
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "Welcome to Team ToolBox, a project to help you work or play with teams/groups randomly!"


        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: "It helps whenever we need to pick someone, don't find volunteers, define teams (practical exercises, collective workshops etc...) , define passing order or assign tasks."

        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: "This tool may be useful for trainers, teachers, managers or anyone else who works with or within groups."


        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: "Note that this project is made just for fun, to begin play with Qt QML, but i will appreciate your feedback"


        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "Initial author: Lionel Duboeuf"


        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Source code"
            onClicked: {
                Qt.openUrlExternally("https://github.com/lduboeuf/qt-ttb");
            }
        }
    }

}
