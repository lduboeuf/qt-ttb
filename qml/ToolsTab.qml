import QtQuick 2.0
import QtQuick.Controls 2.1

Page {
    id: toolsTab
    title: qsTr("Tools")

    //anchors.fill: parent

    header:NavigationBar{}

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        ToolBuild{
        }

        ToolFind{}

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Build Teams")
        }
        TabButton {
            text: qsTr("Find Members")
        }
        TabButton {
            text: "Third"
        }
    }
}
