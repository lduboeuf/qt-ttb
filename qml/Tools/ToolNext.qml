import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Model"
import "../Components"

Page {
    id: toolBuild
    title: qsTr("Who's next")

    property string filter: GroupModel.groupTypePeoplesName

    StackView.onActivated:{ //make sure the list is up to date
        console.log("kikou ici")
        groupModel.clear()
        for (var i=0; i < GroupModel.groupModel.count; i++){
            var row = GroupModel.groupModel.get(i)

            if (row.type === filter){
                groupModel.append(row)
                groupModel.setProperty(0, "selected", false)

            }
        }

    }


    header:NavigationBar{
    }

    Column{
        //anchors.centerIn: parent
        anchors.topMargin: 20
        anchors.fill: parent
        spacing: 16
        Label {
            width: parent.width * 0.6
            wrapMode: Label.Wrap
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Select a group and get a random ordered list:")
        }

        ComboBox{
            id:groupSelect
            anchors.horizontalCenter: parent.horizontalCenter
            textRole: "name"
            width: parent.width * 0.6
            model: ListModel{
               id: groupModel
             }

            onCurrentIndexChanged: {
                if (currentIndex>-1){
                    var selectedGroup = []
                    selectedGroup.push(groupModel.get(currentIndex).rowId)
                    stackView.push("qrc:/qml/Tools/ToolNextResult.qml", {selectedGroup: selectedGroup})
                }

            }
        }
    }






}
