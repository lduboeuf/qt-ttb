import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Model"
import "../Components"


Page {
    id: toolBuildSelect
    title: qsTr("Select Groups")

    property int nbItems: 0
    property string filter: GroupModel.groupTypePeoplesName


    onFilterChanged:{
        model.clear()
        for (var i=0; i < GroupModel.groupModel.count; i++){
            if (GroupModel.groupModel.get(i).type === filter){
                model.append(GroupModel.groupModel.get(i))
            }
        }

    }


    header: NavigationBar{

        id: navBar

        rightActions:[
            Action{
                id: actionOK
                source: "/assets/ok.svg"
                enabled: false
                onTriggered: function(){
                    stackView.replace("qrc:/qml/Tools/ToolBuildResult.qml", {selectedGroup: selectedGroup, nbItems: nbItems})
                }

            }
        ]


    }

    property var selectedGroup: []


    ListView {
        id: selectGroupList
        anchors.fill: parent
        model: ListModel{
            id: model

        }
        // ComboBox closes the popup when its items (anything AbstractButton derivative) are
        //  activated. Wrapping the delegate into a plain Item prevents that.
        delegate: Item {
            width: parent.width
            height: checkDelegate.height

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

                    actionOK.enabled = (selectedGroup.length > 0) ? true: false

                }

            }
        }

    }

}
