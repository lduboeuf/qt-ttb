import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "../Components"
import "../Model"

Page {
    id: categoryForm

    property int index: 0
    property int categoryId:0
    property int rowId:0
    property string name:""

    property bool updateMode: name.length===0 ? false: true

    title: updateMode ? qsTr("Modify Category"): qsTr("Add Category")


    header:NavigationBar{
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
        if ( categoryInput.displayText.trim() == "" ) {
            return
        }

        if (updateMode){
            CategoryModel.update(index, rowId, categoryInput.displayText)
        }else{
            CategoryModel.add(categoryInput.displayText)
        }

        categoryInput.text = ""
        stackView.pop()
    }

    Column {
            spacing: 40
            anchors.margins:16
            anchors.fill: parent

        TextField {
            id: categoryInput
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Category name"
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
    StackView.onActivated: categoryInput.forceActiveFocus()



}
