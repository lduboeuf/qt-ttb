import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3


import "Model"
import "Components"

Page {
    id: settingsPage


    title: qsTr('Settings')
    header:NavigationBar{}

    Column {
        spacing: 40
        anchors.fill: parent
        anchors.topMargin: 40
        anchors.margins: 16
        //padding: 16
//        RowLayout{
//            width: parent.width
//            height: themeSwitchLabel.implicitHeight * 2

//            Label {
//                id:themeSwitchLabel
//                //width: parent.width
//                //wrapMode: Label.Wrap
//                verticalAlignment:  Qt.AlignVCenter
//                text: qsTr("Change Theme:")
//            }

//            Switch {
//                id: themeSwitch
//                padding: 0
//                //text: (settings.theme===Material.Dark) ? qsTr("Dark"): qsTr("Light")
//                checked: (settings.theme===Material.Dark)
//                anchors.right: parent.right
//                onCheckedChanged: {
//                    if (themeSwitch.checked){
//                        settings.theme = Material.Dark
//                    }else{
//                        settings.theme = Material.Light
//                    }

//                }
//            }
//        }

        RowLayout{
            width: parent.width
            Label {
                //width: parent.width
                wrapMode: Label.Wrap
                //horizontalAlignment: Qt.AlignHCenter
                text: qsTr("Reset datas: (long press the button)")
            }

            DelayButton {
                id:deleteButton
                anchors.right: parent.right
                padding:0
                enabled : true
                text: qsTr('OK')
                onActivated: {
                    confirmationDialog.open()
                }
            }
        }





    }
    Dialog {
        id: confirmationDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column {
            spacing: 20
            anchors.fill: parent
            Label {
                text: qsTr("Are you sure you want to delete all datas ?")
            }

        }

        onAccepted: {
            //clear models
            GroupModel.groupModel.clear()
            CategoryModel.categoryModel.clear()
            ItemModel.itemModel.clear()

            Database.dbReset()
            //special case for category, it have default insert data on reset, rebuild the List
            CategoryModel.buildModel()


            confirmationDialog.close()

            deleteButton.text = qsTr('done')
            deleteButton.enabled = false

        }
    }



}
