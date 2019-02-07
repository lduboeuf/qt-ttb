import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import "../Components"


Page {
    id: toolsTab
    title: qsTr("Tools")

    //anchors.fill: parent

    header:NavigationBar{
        subtitle: swipeView.currentItem.title


    }


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        ToolBuild{
            id:toolBuild
        }

        ToolFind{
            id:toolFind
        }


        Label{
            text: qsTr('Not implemented yet')
        }

        Label{
            text: qsTr('Not implemented yet')
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Build")
        }
        TabButton {
            text: qsTr("Find")
        }
        TabButton {
            text: qsTr("Who's next")
        }

        TabButton {
            text: qsTr("Pairs")
        }
    }


}
