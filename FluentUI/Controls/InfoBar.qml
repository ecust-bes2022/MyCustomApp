import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property int severity: InfoBarType.Info
    property string title
    property bool closable: true
    property string message
    property Component titleItem
    property Component messageItem
    property Component action
    property bool iconVisible: true
    property var onClickCloseListener: null
    property int messageMaximumWidth: 520
    Component{
        id: comp_title
        Label{
            font: Typography.bodyStrong
            text: control.title
        }
    }
    property int topPadding: 12
    property int leftPadding: 12
    property int rightPadding: 12
    property int bottomPadding: 12
    implicitWidth: item_content.width + leftPadding + rightPadding
    implicitHeight: item_content.height + topPadding + bottomPadding
    QtObject{
        id: d
        property bool isLong: Number(layout_message.width ) === control.messageMaximumWidth
    }
    Component{
        id: comp_message
        Item{
            implicitWidth: label_visible.implicitWidth
            implicitHeight: lable_message.implicitHeight
            Label{
                id: label_visible
                font: Typography.body
                text: control.message
                wrapMode: Label.WrapAnywhere
                visible: false
            }
            Label{
                id: lable_message
                width: maxWidth+10
                text: control.message
                wrapMode: Label.WrapAnywhere
            }
        }

    }
    Rectangle{
        radius: 4
        anchors.fill: parent
        color: {
            if(severity === InfoBarType.Success){
                return control.FluentUI.theme.res.systemFillColorSuccessBackground
            }else if(severity === InfoBarType.Error){
                return control.FluentUI.theme.res.systemFillColorCriticalBackground
            }else if(severity === InfoBarType.Warning){
                return control.FluentUI.theme.res.systemFillColorCautionBackground
            }
            return control.FluentUI.theme.res.systemFillColorSolidAttentionBackground
        }
        border.width: 1
        border.color: control.FluentUI.theme.res.cardStrokeColorDefault
    }
    Item{
        id: item_content
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
        x: control.leftPadding
        y: control.topPadding
        Icon{
            id: icon_info
            width: 20
            height: 20
            visible: control.iconVisible
            anchors{
                verticalCenter: btn_close.verticalCenter
            }
            color: {
                if(severity === InfoBarType.Success){
                    return control.FluentUI.theme.res.systemFillColorSuccess
                }else if(severity === InfoBarType.Error){
                    return control.FluentUI.theme.res.systemFillColorCritical
                }else if(severity === InfoBarType.Warning){
                    return control.FluentUI.theme.res.systemFillColorCaution
                }
                return control.accentColor.defaultBrushFor(control.FluentUI.dark)
            }
            source: {
                if(severity === InfoBarType.Success){
                    return FluentIcons.graph_CompletedSolid
                }else if(severity === InfoBarType.Error){
                    return FluentIcons.graph_StatusErrorFull
                }
                return FluentIcons.graph_InfoSolid
            }
        }
        AutoLoader{
            id: loader_title
            anchors{
                left: icon_info.right
                leftMargin: visible ? 14 : 0
                verticalCenter: btn_close.verticalCenter
            }
            visible: {
                if(!control.titleItem && control.title===""){
                    return false
                }
                return true
            }
            sourceComponent: {
                if(control.titleItem){
                    return titleItem
                }
                return comp_title
            }
        }
        Item{
            id: layout_message
            anchors{
                left: loader_title.right
                leftMargin: visible ? 14 : 0
                baseline: loader_title.baseline
            }
            width: Math.min(Math.min(loader_message.width,control.messageMaximumWidth),loader_message.width)
            height: loader_message.height
            visible: {
                if(!control.messageItem && control.message===""){
                    return false
                }
                return true
            }
            states: State {
                when: d.isLong
                AnchorChanges {
                    target: layout_message
                    anchors{
                        top: loader_title.bottom
                        left: loader_title.left
                        baseline: undefined
                    }
                }
                PropertyChanges {
                    target: layout_message
                    anchors.leftMargin: 0
                    anchors.topMargin: 6
                }
            }
            AutoLoader{
                id: loader_message
                property int maxWidth: layout_message.width
                sourceComponent: {
                    if(control.messageItem){
                        return control.messageItem
                    }
                    return comp_message
                }
            }
        }
        AutoLoader{
            id: loader_action
            anchors{
                left: layout_message.right
                leftMargin: visible ? 14 : 0
            }
            sourceComponent: control.action
            visible: control.action
            states: State {
                when: d.isLong
                AnchorChanges {
                    target: loader_action
                    anchors{
                        top: layout_message.bottom
                        left: layout_message.left
                    }
                }
                PropertyChanges {
                    target: loader_action
                    anchors.leftMargin: 0
                    anchors.topMargin: 14
                }
            }
        }
        IconButton{
            id: btn_close
            anchors{
                left: loader_action.right
                leftMargin: 14
            }
            icon.name: FluentIcons.graph_ChromeClose
            icon.width: 14
            icon.height: 14
            visible: control.closable
            states: State {
                when: d.isLong
                AnchorChanges {
                    target: btn_close
                    anchors{
                        left: layout_message.right
                    }
                }
                PropertyChanges {
                    target: btn_close
                    anchors.leftMargin: 0
                }
            }
            onClicked: {
                if(control.onClickCloseListener === null){
                    control.visible = false
                }else{
                    control.onClickCloseListener()
                }
            }
        }
    }
}
