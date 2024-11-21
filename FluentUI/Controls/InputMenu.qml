import QtQuick
import QtQuick.Controls
import FluentUI.impl

Loader{
    id: control
    FluentUI.theme: Theme.of(control)
    property string cutText : qsTr("Cut")
    property string copyText : qsTr("Copy")
    property string pasteText : qsTr("Paste")
    property string undoText : qsTr("Undo")
    property string selectAllText : qsTr("Select All")
    property var targetItem
    function popup(){
        control.sourceComponent = comp_menu
    }
    width: 180
    Component{
        id: comp_menu
        Menu{
            id: popup
            width: control.width
            focus: false
            Component.onCompleted: {
                popup.popup()
            }
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            onClosed:{
                control.sourceComponent = undefined
            }
            onVisibleChanged: {
                if(targetItem){
                    targetItem.forceActiveFocus()
                }
                if(visible && !item_clip.visible && !item_copy.visible && !item_paste.visible && !item_undo.visible && !item_select_all.visible){
                    visible = false
                    width = 0
                    clip = true
                }else{
                    width = control.width
                    clip = false
                }
            }
            enter: Transition {}
            exit: Transition {}
            Connections{
                target: {
                    if(targetItem){
                        return targetItem
                    }
                    return null
                }
                function onTextChanged() {
                    popup.close()
                }
                function onActiveFocusChanged() {
                    if(!targetItem.activeFocus){
                        popup.close()
                    }
                }
            }
            Item{
                id: item_clip
                height: visible ? 38 : 0
                visible: {
                    if(targetItem){
                        return targetItem.selectedText !== "" && !targetItem.readOnly
                    }
                    return false
                }
                ListTile{
                    anchors{
                        fill: parent
                        margins: 3
                    }
                    text:cutText
                    onClicked: {
                        targetItem.cut()
                        popup.close()
                    }
                    leading: Icon{
                        source: FluentIcons.graph_Cut
                        width: 16
                        height: 16
                    }
                    trailing: Label{
                        text: "Ctrl+X"
                        color: control.FluentUI.theme.res.textFillColorTertiary
                    }
                }
            }
            Item{
                id: item_copy
                height: visible ? 38 : 0
                visible: {
                    if(targetItem){
                        return targetItem.selectedText !== ""
                    }
                    return false
                }
                ListTile{
                    anchors{
                        fill: parent
                        margins: 3
                    }
                    text: copyText
                    onClicked: {
                        targetItem.copy()
                        popup.close()
                    }
                    leading: Icon{
                        source: FluentIcons.graph_Copy
                        width: 16
                        height: 16
                    }
                    trailing: Label{
                        text: "Ctrl+C"
                        color: control.FluentUI.theme.res.textFillColorTertiary
                    }
                }
            }
            Item{
                id: item_paste
                height: visible ? 38 : 0
                visible: targetItem.canPaste
                ListTile{
                    anchors{
                        fill: parent
                        margins: 3
                    }
                    text: pasteText
                    onClicked: {
                        targetItem.paste()
                        popup.close()
                    }
                    leading: Icon{
                        source: FluentIcons.graph_Paste
                        width: 16
                        height: 16
                    }
                    trailing: Label{
                        text: "Ctrl+V"
                        color: control.FluentUI.theme.res.textFillColorTertiary
                    }
                }
            }
            Item{
                id: item_undo
                height: visible ? 38 : 0
                visible: targetItem.canUndo
                ListTile{
                    anchors{
                        fill: parent
                        margins: 3
                    }
                    text: undoText
                    onClicked: {
                        targetItem.undo()
                        popup.close()
                    }
                    leading: Icon{
                        source: FluentIcons.graph_Undo
                        width: 16
                        height: 16
                    }
                    trailing: Label{
                        text: "Ctrl+Z"
                        color: control.FluentUI.theme.res.textFillColorTertiary
                    }
                }
            }
            Item{
                id: item_select_all
                height: visible ? 38 : 0
                visible: {
                    if(targetItem){
                        return targetItem.text !== ""
                    }
                    return false
                }
                ListTile{
                    anchors{
                        fill: parent
                        margins: 3
                    }
                    text: selectAllText
                    onClicked: {
                        targetItem.selectAll()
                        popup.close()
                    }
                    trailing: Label{
                        text: "Ctrl+A"
                        color: control.FluentUI.theme.res.textFillColorTertiary
                    }
                }
            }
        }
    }
}
