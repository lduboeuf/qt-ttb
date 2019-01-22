import QtQuick 2.6
import QtQuick.Controls 2.0


Page {
    id: page

    default property alias content: pane.contentItem

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane
            width: parent.width
        }

        ScrollIndicator.vertical: ScrollIndicator { }
        //ScrollBar.vertical: ScrollBar { id: scrollBar }
    }
}
