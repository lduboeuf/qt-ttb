import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    width:drawer.width
    height:40

    Row{
        //RowLayout {
        id: menuItem
        anchors.fill: parent
        spacing: 16
        anchors.margins: 16

        Label {
            opacity: 0.87
            font.pixelSize: 14
            font.family: customFont.name
            text: model.icon
            //Layout.fillWidth: true
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter

        }

        Item {
            width: 4
        }

        Label {
            opacity: 0.87
            font.pixelSize: 14
            text: model.title
            //Layout.fillWidth: true
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter
        }


    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            menuList.currentIndex = index
            stackView.push(model.source)
            drawer.close()
        }

    }
}
