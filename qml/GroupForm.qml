import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "Database.js" as DB


Page {
    id: addGroupPage

    property int rowid:0
    property string name:""

    property bool updateMode: name.length==0 ? false: true

    title: updateMode ? qsTr("Modify Group"): qsTr("Add Group")


    header:NavigationBar{
        toolbarButtons: ToolButton {
              id: addActionBar
              anchors.right: parent.right
              contentItem: Image {
                  fillMode: Image.Pad
                  horizontalAlignment: Image.AlignHCenter
                  verticalAlignment: Image.AlignVCenter
                  sourceSize.width: parent.height - (parent.height * 0.4)
                  sourceSize.height: sourceSize.height
                  source: "../assets/ok.svg"
              }

              onClicked: {
                save()
              }
           }
    }

    function save(){
        if ( groupInput.displayText.trim() == "" ) {
            return
        }

        if (updateMode){
            DB.updateGroup(rowid, groupInput.displayText)
        }else{
            DB.insertGroup(groupInput.displayText)
        }

        groupInput.text = ""
        stackView.pop()
    }

    Column {
            spacing: 40
            anchors.margins:16
            anchors.fill: parent

        TextField {
            id: groupInput
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Group name"
            text:  name
            //width: parent.width -this.height

            Keys.onReturnPressed: {
                save()
            }

        }
    }


}
