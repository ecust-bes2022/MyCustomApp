import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.SpinBox {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property bool highlighted: false
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             up.implicitIndicatorHeight, down.implicitIndicatorHeight)

    leftPadding: padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
    rightPadding: padding + (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }
    contentItem: T.TextField {
        z: 2
        text: control.displayText
        clip: width < implicitWidth
        padding: 6
        color: {
            if(!control.enabled){
                return control.FluentUI.theme.res.textFillColorDisabled
            }
            return control.FluentUI.theme.res.textFillColorPrimary
        }
        selectionColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        selectedTextColor: Colors.basedOnLuminance(selectionColor)
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        font: control.font
        renderType: Theme.textRender
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: Item {
        x: control.mirrored ? 0 : control.width - width
        height: control.height
        implicitWidth: 34
        implicitHeight: 32
        Rectangle{
            width: 30
            height: 20
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 4
            }
            radius: 4
            color: {
                if(!enabled){
                    return control.FluentUI.theme.res.controlFillColorDisabled
                }
                if(control.up.pressed){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(control.up.hovered){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
            Icon{
                source: FluentIcons.graph_ChevronRight
                width: 12
                height: 12
                anchors.centerIn: parent
                color: enabled ? control.FluentUI.theme.res.textFillColorPrimary : control.FluentUI.theme.res.textFillColorDisabled
            }
        }
    }

    down.indicator: Item {
        x: control.mirrored ? parent.width - width : 0
        height: control.height
        implicitWidth: 34
        implicitHeight: 32
        Rectangle{
            width: 30
            height: 20
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 4
            }
            radius: 4
            color: {
                if(!enabled){
                    return control.FluentUI.theme.res.controlFillColorDisabled
                }
                if(control.down.pressed){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(control.down.hovered){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
            Icon{
                source: FluentIcons.graph_ChevronLeft
                width: 12
                height: 12
                anchors.centerIn: parent
                color: enabled ? control.FluentUI.theme.res.textFillColorPrimary : control.FluentUI.theme.res.textFillColorDisabled
            }
        }
    }

    background: Item{
        implicitWidth: 140
        InputBackground {
            anchors.fill: parent
            target: control
            radius: 4
            activeColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        }
    }


}
