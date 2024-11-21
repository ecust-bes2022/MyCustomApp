import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.MenuBarItem {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    spacing: 6
    padding: 10
    horizontalPadding: padding + 2
    icon.width: 16
    icon.height: 16
    icon.color: control.FluentUI.textColor
    font: Typography.body
    FluentUI.textColor: {
        if(!control.enabled){
            return control.FluentUI.theme.res.textFillColorDisabled
        }
        if(control.pressed){
            return control.FluentUI.theme.res.textFillColorSecondary
        }
        return control.FluentUI.theme.res.textFillColorPrimary
    }
    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignHCenter | Qt.AlignVCenter
        icon: control.icon
        text: control.text
        font: control.font
        color: control.FluentUI.textColor
    }
    background: Item{
        implicitHeight: 30
        implicitWidth: 30
        x: 1
        y: 1
        width: control.width - 2
        height: control.height - 2
        Rectangle{
            radius: control.FluentUI.radius
            anchors.fill: parent
            anchors.margins: 3
            color: control.highlighted ? control.FluentUI.theme.res.subtleFillColorSecondary : Theme.uncheckedInputColor(control,true,true,control.FluentUI.dark)
        }
    }
}
