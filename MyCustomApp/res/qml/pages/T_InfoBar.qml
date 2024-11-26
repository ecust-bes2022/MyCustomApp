import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl
import Gallery

ScrollablePage {

    id: page
    title: qsTr("InfoBar")
    columnSpacing: 24

    property var types : [InfoBarType.Success,InfoBarType.Info,InfoBarType.Warning,InfoBarType.Warning,InfoBarType.Error]


    InfoBarManager{
        id: info_manager_topright
        target: page
        edge: Qt.TopEdge | Qt.RightEdge
    }

    InfoBarManager{
        id: info_manager_top
        target: page
        edge: Qt.TopEdge
    }

    InfoBarManager{
        id: info_manager_topleft
        target: page
        edge: Qt.TopEdge | Qt.LeftEdge
    }

    InfoBarManager{
        id: info_manager_bottomright
        target: page
        edge: Qt.BottomEdge | Qt.RightEdge
    }

    InfoBarManager{
        id: info_manager_bottom
        target: page
        edge: Qt.BottomEdge
    }

    InfoBarManager{
        id: info_manager_bottomleft
        target: page
        edge: Qt.BottomEdge | Qt.LeftEdge
    }

    InfoBarManager{
        id: info_manager_custom
        target: page
        edge: Qt.TopEdge | Qt.RightEdge
    }

    RowLayout{
        spacing: 14
        Button{
            text: qsTr("Top right")
            onClicked: {
                info_manager_topright.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Top right"))
            }
        }
        Button{
            text: qsTr("Top")
            onClicked: {
                info_manager_top.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Top"))
            }
        }
        Button{
            text: qsTr("Top left")
            onClicked: {
                info_manager_topleft.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Top left"))
            }
        }
        Button{
            text: qsTr("Bottom right")
            onClicked: {
                info_manager_bottomright.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Bottom right"))
            }
        }
        Button{
            text: qsTr("Bottom")
            onClicked: {
                info_manager_bottom.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Bottom"))
            }
        }
        Button{
            text: qsTr("Bottom left")
            onClicked: {
                info_manager_bottomleft.show(types[Math.floor(Math.random() * types.length)],qsTr("This is an InfoBar in the Bottom left"))
            }
        }
    }

    RowLayout{
        spacing: 14
        Button{
            text: qsTr("Info")
            onClicked: {
                infoBarManager.showInfo(qsTr("This is an InfoBar in the Info Style"))
            }
        }
        Button{
            text: qsTr("Warning")
            onClicked: {
                infoBarManager.showWarning(qsTr("This is an InfoBar in the Warning Style"))
            }
        }
        Button{
            text: qsTr("Error")
            onClicked: {
                infoBarManager.showError(qsTr("This is an InfoBar in the Error Style"))
            }
        }
        Button{
            text: qsTr("Success")
            onClicked: {
                infoBarManager.showSuccess(qsTr("This is an InfoBar in the Success Style"))
            }
        }
    }

    Component{
        id: comp_action
        Button{
            text: "Action"
            onClicked: {
                if(model.severity !== InfoBarType.Success){
                    model.severity = InfoBarType.Success
                }else{
                    infoControl.remove(model.index)
                }
            }
        }
    }
    Component{
        id: com_custom
        Pane{
            width: 400
            height: 100
            ProgressRing{
                anchors.centerIn: parent
                indeterminate: true
            }
        }
    }
    RowLayout{
        spacing: 14
        Button{
            text: qsTr("More Message")
            onClicked: {
                info_manager_top.showWarning(qsTr("Title"),0,qsTr("Essential app message for your users to be informed of, acknowledge, or take action on. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),comp_action)
            }
        }
        Button{
            text: qsTr("Custom Info Bar")
            onClicked: {
                info_manager_custom.showCustom(com_custom)
            }
        }
    }
    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet: `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import FluentUI.impl

ColumnLayout{
    width: parent.width
    RowLayout{
        spacing: 16
        Label{
            text: "severity"
        }
        ComboBox{
            id: combobox
            textRole: "title"
            model: [{title:"Info",type:InfoBarType.Info},{title:"Warning",type:InfoBarType.Warning},{title:"Error",type:InfoBarType.Error},{title:"Success",type:InfoBarType.Success}]
        }
    }
    InfoBar {
        severity: combobox.currentValue.type
        onSeverityChanged:{
            visible = true
        }
        title: "Short Message"
        message: "Essential app message for your users to be informed of, acknowledge"
        action: Button{
            text: "action"
        }
    }
    InfoBar {
        severity: combobox.currentValue.type
        onSeverityChanged:{
            visible = true
        }
        title: "Long Message"
        message: "Essential app message for your users to be informed of, acknowledge, or take action on. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        action: Button{
            text: "action"
        }
    }
}`}
}
