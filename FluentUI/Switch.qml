import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Switch {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: 8
    spacing: 8
    font: Typography.body
    focusPolicy: Qt.TabFocus
    indicator: Rectangle {
        id: indicator
        width: 40
        height: 20
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        radius: height / 2
        color: {
            if(control.checked){
                return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
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
        border.width: 1
        border.color: {
            if(control.checked){
                return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
            }else{
                if(!control.enabled){
                    return control.FluentUI.theme.res.controlStrongFillColorDisabled
                }
                return control.FluentUI.theme.res.controlStrongFillColorDefault
            }
        }
        Rectangle {
            id: handle
            readonly property int offset: 4
            x: Math.max(offset, Math.min(parent.width - offset - width,control.visualPosition * parent.width - (width / 2)))
            y: (parent.height - height) / 2
            width: {
                if(control.pressed){
                    return 17
                }
                return 14
            }
            height: 14
            scale: {
                if(!control.enabled){
                    return 0.857
                }
                if(control.hovered){
                    return 1.0
                }
                return 0.857
            }
            radius: width / 2
            color: {
                if(control.checked){
                    if(!control.enabled){
                        return control.FluentUI.theme.res.textOnAccentFillColorDisabled
                    }
                    return control.FluentUI.theme.res.textOnAccentFillColorPrimary
                }else{
                    if(!control.enabled){
                        return control.FluentUI.theme.res.textFillColorDisabled
                    }
                    return control.FluentUI.theme.res.textFillColorSecondary
                }
            }
            Behavior on x {
                enabled: !control.pressed
                NumberAnimation {
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
            Behavior on width{
                enabled: control.pressed
                NumberAnimation {
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
    contentItem: Label {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
    background: FocusItem{
        target: control
    }
}
