import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "Database.js" as DB


Page {
    id: memberForm

    property int group_id:0
    property int rowid:0
    property string name:""

    property bool updateMode: name.length===0 ? false: true

    title: updateMode ? qsTr("Modify Member"): qsTr("Add Member")


    header:NavigationBar{
        toolbarButtons: ToolButton {
              id: addActionBar
              anchors.right: parent.right
              contentItem: Image {
                  fillMode: Image.Pad
                  horizontalAlignment: Image.AlignHCenter
                  verticalAlignment: Image.AlignVCenter
                  sourceSize.width: parent.height  * 0.4
                  sourceSize.height: sourceSize.height
                  source: "../assets/ok.svg"
              }

              onClicked: {
                save()
              }
           }
    }

    function save(){
        if ( memberInput.displayText.trim() == "" ) {
            return
        }

        if (updateMode){
            DB.updateMember(rowid, memberInput.displayText)
        }else{
            DB.insertMember(group_id, memberInput.displayText)
        }

        memberInput.text = ""
        stackView.pop()
    }

    Column {
            spacing: 40
            anchors.margins:16
            anchors.fill: parent

        TextField {
            id: memberInput
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Member name"
            text:  name
            //width: parent.width -this.height

            Keys.onReturnPressed: {
                save()
            }

        }
    }


}
