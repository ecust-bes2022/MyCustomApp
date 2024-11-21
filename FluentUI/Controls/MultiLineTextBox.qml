import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import FluentUI.impl

T.TextArea {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    property Component leading
    property Component trailing
    readonly property bool pressed: tap_handler.pressed
    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset)
    padding: 6
    topPadding: padding+2
    leftPadding: padding + (control.leading ? 0 : 4) + loader_leading.width + loader_leading.anchors.leftMargin
    rightPadding: padding + loader_trailing.width + loader_trailing.anchors.rightMargin
    font: Typography.body
    color: {
        if(!enabled){
            return control.FluentUI.theme.res.textFillColorDisabled
        }
        return control.FluentUI.theme.res.textFillColorPrimary
    }
    selectionColor: accentColor.defaultBrushFor(control.FluentUI.dark)
    selectedTextColor: Colors.basedOnLuminance(selectionColor)
    renderType: Theme.textRender
    placeholderTextColor: control.FluentUI.theme.res.textFillColorSecondary
    TapHandler{
        id: tap_handler
    }
    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }
    background: InputBackground {
        implicitWidth: 200
        implicitHeight: 32
        radius: control.FluentUI.radius
        activeColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        color: {
            if(!control.enabled){
                return control.FluentUI.theme.res.controlFillColorDisabled
            }else if(control.activeFocus){
                return control.FluentUI.theme.res.controlFillColorInputActive
            }else if(control.hovered){
                return control.FluentUI.theme.res.controlFillColorSecondary
            }else{
                return control.FluentUI.theme.res.controlFillColorDefault
            }
        }
        target: control
    }
    AutoLoader{
        id: loader_leading
        sourceComponent: control.leading
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: control.leading ? 6 : 0
        }
    }
    AutoLoader{
        id: loader_trailing
        sourceComponent: control.trailing
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: control.trailing ? 6 : 0
        }
    }
    TapHandler{
        acceptedButtons: Qt.RightButton
        onTapped: {
            menu.popup()
        }
    }
    InputMenu{
        id: menu
        targetItem: control
    }
}
