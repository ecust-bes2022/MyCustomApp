import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import QtQuick.Layouts
import FluentUI.Controls
import FluentUI.impl

T.TabButton {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    FluentUI.textColor: {
        if(!control.enabled){
            return control.FluentUI.theme.res.textFillColorDisabled
        }
        if(control.pressed){
            return control.FluentUI.theme.res.textFillColorSecondary
        }
        if(control.hovered || control.checked){
            return control.FluentUI.theme.res.textFillColorPrimary
        }
        return control.FluentUI.theme.res.textFillColorTertiary
    }
    spacing: 14
    focusPolicy: Qt.TabFocus
    width: implicitWidth
    font: Typography.title
    icon.color: control.FluentUI.textColor
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
        radius: control.FluentUI.radius
        target: control
    }
}
