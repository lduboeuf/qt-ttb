import QtQuick 2.9
import QtQuick.Controls 2.2

ScrollablePage{

    //topPadding: 16
    title: qsTr("About")

    Column {
        id: column
        spacing: 40
        width: parent.width


        Text{
            id:content
            anchors.margins: 16
            width: parent.width
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter


            text: "Welcome to Team ToolBox, a project to help you work or play with teams/groups randomly!

It helps whenever we need to pick someone, don't find volunteers, define teams (practical exercises, collective workshops etc...) , define passing order or assign tasks.

This tool may be useful for trainers, teachers, managers or anyone else who works with or within groups.


Author: Lionel Duboeuf"

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
