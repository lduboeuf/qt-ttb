import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "../Components"
import "../Model"

Page {
    id: memberForm

    property int index: 0
    property int groupId:0
    property string groupName : ""
    property int rowId:0
    property string name:""

    property bool updateMode: name.length===0 ? false: true

    title: groupName


    header:NavigationBar{
        subtitle: updateMode ? qsTr("Edit Member"): qsTr("Add Member")

        rightActions:[
            Action{
                id: actionOK
                source: "/assets/ok.svg"
                enabled: false
                onTriggered: function(){
                    save()
                }

            }
        ]
    }

    function save(){
        if ( memberInput.displayText.trim() == "" ) {
            return
        }

        if (updateMode){
            ItemModel.updateMember(index, rowId, memberInput.displayText)
        }else{
            ItemModel.insertMember(groupId, memberInput.displayText)
        }

        memberInput.text = ""
        stackView.pop(StackView.Immediate)
    }

    Column {
            spacing: 40
            anchors.margins:16
            anchors.fill: parent

        TextField {
            id: memberInput
            width: parent.width * 0.8
            maximumLength: 26
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Member name"
            text:  name
            inputMethodHints: Qt.ImhNoPredictiveText; //workaround for onTextChanged not fired on mobile

            //width: parent.width -this.height

            Keys.onReturnPressed: {
                save()
            }

            onDisplayTextChanged: {
                actionOK.enabled = (text.length > 0) ? true: false
            }

        }
    }
    StackView.onActivated: memberInput.forceActiveFocus()



}
