import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.RadioButton {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: 6
    spacing: 6
    font: Typography.body
    focusPolicy: Qt.TabFocus
    indicator: Rectangle {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: width / 2
        color: {
            if(control.checked){
                return control.FluentUI.theme.res.textOnAccentFillColorPrimary
            }else{
                if(!control.enabled){
                    return control.FluentUI.theme.res.controlAltFillColorDisabled
                }
                if(control.pressed){
                    return control.FluentUI.theme.res.controlAltFillColorQuarternary
                }
                if(control.hovered){
                    return control.FluentUI.theme.res.controlAltFillColorTertiary
                }
                return control.FluentUI.theme.res.controlAltFillColorSecondary
            }
        }
        border.width: {
            if(control.checked){
                if(control.enabled){
                    if(control.hovered && !control.pressed){
                         return 3.4
                    }
                    return 5.0
                }else{
                    return 4.0
                }
            }else{
                if(control.pressed){
                    return 4.5
                }
                return 1
            }
        }
        border.color: {
            if(control.checked){
                return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
            }else{
                if(!control.enabled){
                    return control.FluentUI.theme.res.textFillColorDisabled
                }
                if(control.pressed){
                    return control.accentColor.defaultBrushFor(control.FluentUI.dark)
                }
                return control.FluentUI.theme.res.textFillColorTertiary
            }
        }
        Behavior on border.width {
            NumberAnimation{
                duration: Theme.fastAnimationDuration
                easing.type: Theme.animationCurve
            }
        }
    }
    contentItem: Label {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        verticalAlignment: Qt.AlignVCenter
    }
    background: FocusItem{
        target: control
    }
}
