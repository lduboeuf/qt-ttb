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



        Label{
            id:content
            anchors.margins: 16
            width: parent.width
            font.pixelSize: Qt.application.font.pixelSize * 1.1
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: qsTr("Welcome to Team ToolBox, a project to help you work or play with teams/groups randomly!")


        }

        Label{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: qsTr("It helps whenever we need to pick someone, don't find volunteers, define teams (practical exercises, collective workshops etc...) , define passing order or assign tasks.")

        }

        Label{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: qsTr("This tool may be useful for trainers, teachers, managers or anyone else who works with or within groups.")


        }

        Label{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize * 1.1

            horizontalAlignment: Qt.AlignHCenter


            text: qsTr("Note that this project is made just for fun, to begin play with Qt QML, but i will appreciate your feedback")


        }

        Label{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: qsTr("Initial author") + ": Lionel Duboeuf"


        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Source code")
            onClicked: {
                Qt.openUrlExternally("https://github.com/lduboeuf/qt-ttb");
            }
        }
    }

}
