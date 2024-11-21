import QtQuick
import QtQuick.Window
import QtQuick.Controls
import FluentUI.Controls
import QtQuick.Controls.impl
import QtQuick.Templates as T
import FluentUI.impl

T.ComboBox {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    property string placeholderText: qsTr("Please select")
    property bool highlighted: false
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    font: Typography.body
    editable: false
    property alias selectedItems: selected_items
    property alias visualModel: visual_model
    DelegateModel {
        id: visual_model
        model: control.model
        groups: [
            DelegateModelGroup {
                id: selected_items
                name: "selected"
            }
        ]
        delegate: control.delegate
    }
    delegate: ListTile {
        id: control_item
        width: ListView.view.width
        text: control.textRole ? control.model instanceof Array ? model.modelData[control.textRole] : model[control.textRole] : model.modelData
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
        font: control.font
        leading: CheckBox{
            checkable: false
            checked: control_item.DelegateModel.inSelected
            onClicked: {
                control_item.clicked()
            }
        }
        spacing: 0
        leftPadding: 6
        rightPadding: 6
        background: FocusItem{
            radius: 4
            implicitHeight: 36
            implicitWidth: 100
            target: control_item
            Rectangle{
                radius: 4
                anchors{
                    fill: parent
                    leftMargin: 6
                    rightMargin: 6
                    topMargin: 2
                    bottomMargin: 2
                }
                color: control_item.DelegateModel.inSelected ? control.FluentUI.theme.res.subtleFillColorSecondary : Theme.uncheckedInputColor(control_item,true,true,control.FluentUI.dark)
            }
        }
        onClicked: {
            control_item.DelegateModel.inSelected = !control_item.DelegateModel.inSelected
        }
    }
    indicator: Item{
        width: 35
        height: 35
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        Icon {
            color: control.enabled ? control.FluentUI.theme.res.textFillColorSecondary : control.FluentUI.theme.res.textFillColorDisabled
            source: FluentIcons.graph_ChevronDown
            width: 12
            height: 12
            anchors.centerIn: parent
        }
    }
    contentItem: T.TextField {
        leftPadding: 12
        autoScroll: false
        readOnly: true
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        selectByMouse: false
        color: {
            if(!control.enabled){
                return control.FluentUI.theme.res.textFillColorDisabled
            }
            return control.FluentUI.theme.res.textFillColorPrimary
        }
        placeholderText: list_view_chip.count === 0 ? control.placeholderText : ""
        placeholderTextColor: control.FluentUI.theme.res.textFillColorSecondary
        font: Typography.body
        renderType: Theme.textRender
        selectionColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        selectedTextColor: Colors.basedOnLuminance(selectionColor)
        verticalAlignment: Text.AlignVCenter
        z: 999
        PlaceholderText {
            id: placeholder
            x: parent.leftPadding
            y: parent.topPadding
            width: parent.width - (parent.leftPadding + parent.rightPadding)
            height: parent.height - (parent.topPadding + parent.bottomPadding)
            text: parent.placeholderText
            font: parent.font
            color: parent.placeholderTextColor
            verticalAlignment: parent.verticalAlignment
            visible: !parent.length && !parent.preeditText && (!parent.activeFocus || parent.horizontalAlignment !== Qt.AlignHCenter)
            elide: Text.ElideRight
            renderType: parent.renderType
        }
        Item{
            anchors.fill: contentItem
            ListView{
                id: list_view_chip
                width: Math.min(parent.width-10,contentItem.childrenRect.width)
                height: contentItem.childrenRect.height
                boundsBehavior: ListView.StopAtBounds
                delegate: Chip{
                    property var __model: selectedItems.get(model.index).model
                    text: control.textRole ? __model.modelData[control.textRole] : __model.modelData
                    onCloseClicked: {
                        selectedItems.get(model.index).inSelected = false
                    }
                }
                spacing: 5
                clip: true
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                orientation: ListView.Horizontal
                model: control.selectedItems.count
            }
        }
        TapHandler{
            onTapped: {
                if(popup.visible){
                    popup.close()
                }else{
                    popup.open()
                }
            }
        }
    }
    background: Item{
        implicitWidth: 180
        implicitHeight: 35
        InputBackground {
            anchors.fill: parent
            target: control
            radius: 4
            activeColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        }
    }
    popup: T.Popup {
        width: control.width
        height: Math.min(contentItem.implicitHeight + topPadding + bottomPadding, control.Window.height - topMargin - bottomMargin)
        FluentUI.dark: control.FluentUI.dark
        FluentUI.primaryColor: control.FluentUI.primaryColor
        verticalPadding: 4
        y: control.height
        enter: Transition {
            NumberAnimation { property: "height"; from: control.popup.height / 3; to: control.popup.height; easing.type: Theme.animationCurve; duration: Theme.fastAnimationDuration }
        }
        contentItem: ListView {
            id: list_view
            clip: true
            implicitHeight: Math.min(contentHeight,control.FluentUI.minimumHeight)
            width: control.width
            model: visual_model
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            boundsBehavior: ListView.StopAtBounds
            ScrollBar.vertical: ScrollBar {}
        }
        background: Rectangle{
            radius: 4
            border.width: 1
            color: control.FluentUI.theme.res.popupBackgroundColor
            border.color: control.FluentUI.theme.res.popupBorderColor
            Shadow{
                radius: 4
            }
        }
    }
}
