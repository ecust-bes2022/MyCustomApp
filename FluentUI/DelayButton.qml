import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import FluentUI.impl
import FluentUI.Controls

T.DelayButton {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: 6
    horizontalPadding: padding + 2
    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
        }
    }
    font: Typography.body
    FluentUI.textColor: {
        if(control.checked){
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
    focusPolicy: Qt.TabFocus
    contentItem: ItemGroup {
        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding + control.progress * control.width
            clipWidth: (1.0 - control.progress) * control.width
            visible: control.progress < 1
            text: control.text
            font: control.font
            color: control.FluentUI.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding
            clipWidth: control.progress * control.width
            visible: control.progress > 0
            text: control.text
            font: control.font
            color: control.FluentUI.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }
    background: FocusItem{
        implicitHeight: 30
        implicitWidth: 30
        radius: control.FluentUI.radius
        target: control
        ControlBackground {
            anchors.fill: parent
            radius: control.FluentUI.radius
            target: control
            accentColor: control.accentColor
            highlighted: control.checked
        }
        ControlBackground {
            width: control.progress * parent.width
            height: parent.height
            radius: control.FluentUI.radius
            target: control
            accentColor: control.accentColor
            highlighted: true
            visible: !control.checked
        }
    }
}
