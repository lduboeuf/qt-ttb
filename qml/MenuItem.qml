import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

ItemDelegate{
    RowLayout {
        spacing: 16
        anchors.margins: 16
        anchors.fill: parent

        Label {
            opacity: 0.87
            font.pixelSize: 14
            font.family: customFont.name
            text: model.icon
            Layout.fillWidth: true
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            width: 36 - (2 * spacing)
        }

        Label {
            opacity: 0.87
            font.pixelSize: 14
            text: model.title
            Layout.fillWidth: true
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter
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
}
