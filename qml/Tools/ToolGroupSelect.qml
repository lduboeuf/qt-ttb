import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Model"
import "../Components"


Page {
    id: toolBuildSelect
    title: qsTr("Select Groups")

    property int nbItems: 0

    header: NavigationBar{

        toolbarButtons: ToolButton {
            id: validateActionBtn
            anchors.right: parent.right
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                sourceSize.width: parent.height  * 0.4
                sourceSize.height: sourceSize.height
                source: "/assets/ok.svg"
            }

            onClicked: {
                stackView.replace("qrc:/qml/Tools/ToolBuildResult.qml", {selectedGroup: selectedGroup, nbItems: nbItems})

            }
        }

    }

    property var selectedGroup: []

    function go(){
        console.log(selectedGroup)
    }


    ListView {
        id: selectGroupList
        anchors.fill: parent
        model: GroupModel.groupModel


        // ComboBox closes the popup when its items (anything AbstractButton derivative) are
        //  activated. Wrapping the delegate into a plain Item prevents that.
        delegate: Item {
            width: parent.width
            height: (model.type===GroupModel.groupTypePeoplesName) ? checkDelegate.height: 0 //only display people type groups

            function toggle() { checkDelegate.toggle() }

            CheckDelegate {
                id: checkDelegate
                anchors.fill: parent
                text: model.name
                highlighted: selectGroupList.highlightedIndex === index
                checked: selectedGroup.indexOf(index) !== -1
                onCheckedChanged: {
                    var idx = selectedGroup.indexOf(rowId)
                    if (idx === -1){
                        selectedGroup.push(rowId)
                    }else{
                        selectedGroup.splice(idx, 1)
                    }
                }

            }
        }

    }

}
