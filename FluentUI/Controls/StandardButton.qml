import QtQuick
import QtQuick.Templates as T
import FluentUI.impl

T.Button {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: 6
    horizontalPadding: padding + 2
    spacing: 6
    icon.width: 24
    icon.height: 24
    icon.color: control.FluentUI.textColor
    focusPolicy: Qt.TabFocus
    font: Typography.body
    FluentUI.textColor: {
        if(control.highlighted){
            if(!control.enabled){
                return control.FluentUI.theme.res.textOnAccentFillColorDisabled
            }
            if(control.pressed){
                return control.FluentUI.theme.res.textOnAccentFillColorSecondary
            }
            if(control.hovered){
                return control.FluentUI.theme.res.textOnAccentFillColorPrimary
            }
            return control.FluentUI.theme.res.textOnAccentFillColorPrimary
        }else{
            if(!control.enabled){
                return control.FluentUI.theme.res.textFillColorDisabled
            }
            if(control.pressed){
                return control.FluentUI.theme.res.textFillColorSecondary
            }
            if(control.flat && control.hovered){
                return control.FluentUI.theme.res.textFillColorTertiary
            }
            return control.FluentUI.theme.res.textFillColorPrimary
        }
    }
    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.FluentUI.textColor
    }
    background: FocusItem{
        implicitHeight: 30
        implicitWidth: 30
        radius: control.FluentUI.radius
        target: control
        ControlBackground {
            id: control_background
            anchors.fill: parent
            radius: control.FluentUI.radius
            target: control
            highlighted: control.highlighted
            visible: !control.flat || control.down || control.checked || control.highlighted
        }
    }
}
