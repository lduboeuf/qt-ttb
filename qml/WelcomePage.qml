import QtQuick 2.9
import QtQuick.Controls 2.2
import "Components"

Page{

    //topPadding: 16
    title: qsTr("Welcome")

    header:NavigationBar{


        leftAction.visible: false

        rightActions:[
            Action{
                id: actionClose
                source: "/assets/close.svg"
                onTriggered: function(){
                    stackView.pop()
                }

            }
        ]


    }



    Column {
        id: column
        //width: parent.width
        //height: parent.height
        //property bool
        //anchors.fill: parent
        //anchors.centerIn: parent
        width:parent.width
        height: parent.height
        padding: 20
        spacing: 16

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
            //anchors.centerIn: parent
            //anchors.margins: 16
            padding: 16
            horizontalAlignment: Text.AlignJustify
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Qt.application.font.pixelSize * 1.2

            width: parent.width
            wrapMode: Text.Wrap



            text: qsTr("<strong>hello ;-)</strong>. Welcome to <strong>Team Tool Box!</strong><br><br> Maybe your first time here. You can start adding Groups and Items by selecting \"My Groups\" in side menu")

        }


    }
//    Timer {
//        interval: 5000; running: true; repeat: false
//        onTriggered: drawer.open()

//    }

}
