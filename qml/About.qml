import QtQuick 2.9
import QtQuick.Controls 2.2
import "Components"

Page{

    //topPadding: 16
    title: qsTr("About")

    header:NavigationBar{}

    Column {
        id: column
        spacing: 40
        anchors.margins: 16
        anchors.fill: parent


        Text{
            id:content
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "Welcome to Team ToolBox, a project to help you work or play with teams/groups randomly!"


        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "It helps whenever we need to pick someone, don't find volunteers, define teams (practical exercises, collective workshops etc...) , define passing order or assign tasks."

        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "This tool may be useful for trainers, teachers, managers or anyone else who works with or within groups."


        }

        Text{
            anchors.margins: 16
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "Author: Lionel Duboeuf"


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
