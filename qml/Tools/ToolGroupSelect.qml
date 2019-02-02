import QtQuick 2.9
import QtQuick.Controls 2.2
import "../Model"
import "../Components"


Page {
    id: toolBuildSelect
    title: qsTr("Build Teams")


    property int nbItems: 0
    property string filter: GroupModel.groupTypePeoplesName
    property int nbSelectedGroup: 0

    onNbSelectedGroupChanged: {
        actionOK.enabled = (nbSelectedGroup > 0)
    }


    onFilterChanged:{
        groupModel.clear()
        for (var i=0; i < GroupModel.groupModel.count; i++){
            var row = GroupModel.groupModel.get(i)

            if (row.type === filter){
                groupModel.append(row)
                groupModel.setProperty(0, "selected", false)

            }
        }

    }



    header: NavigationBar{

        id: navBar

        subtitle: qsTr("Select Groups")

        rightActions:[
            Action{
                id: actionOK
                source: "/assets/ok.svg"
                enabled: false
                onTriggered: function(){
                    var selectedGroup = []
                    for (var i =0; i < groupModel.count; i++){
                        var row = groupModel.get(i)
                        if (row.selected) selectedGroup.push(row.rowId)
                    }

                    stackView.replace("qrc:/qml/Tools/ToolBuildResult.qml", {selectedGroup: selectedGroup, nbItems: nbItems})
                }

            }
        ]


    }




    ListView {
        id: selectGroupList
        anchors.fill: parent
        model: ListModel{
            id: groupModel

        }

        section {
            property: "categoryName"
            criteria: ViewSection.FullString
            delegate: Item {
                width: parent.width
                height: sectionDelegate.height

                Rectangle {
                    color: "lightgrey"
                    width: selectGroupList.width
                    anchors.top: parent.bottom
                    height: 1

                }

                CheckDelegate {
                    id: sectionDelegate
                    anchors.fill: parent
                    text: section
                    opacity: 0.60

                    onCheckedChanged: {

                        for (var i=0; i < groupModel.count; i++){

                            var row = groupModel.get(i)
                            if (row.categoryName===section){

                                row.selected = checked
                                //(checked) ? nbSelectedGroup++ : nbSelectedGroup--


                            }

                        }

                    }

                }
            }
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
                anchors.leftMargin: 16
                text: name
                highlighted: selectGroupList.highlightedIndex === index
                checked: selected
                onCheckedChanged: {
                    //model.selected = checked

                    (checkDelegate.checked) ? nbSelectedGroup++ : nbSelectedGroup--

                    //actionOK.enabled = (selectedGroup.length > 0) ? true: false

                }

            }

        }

    }

}
