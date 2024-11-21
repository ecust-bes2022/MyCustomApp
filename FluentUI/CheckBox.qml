import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.CheckBox {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: 6
    spacing: 6
    focusPolicy: Qt.TabFocus
    font: Typography.body
    indicator: Item {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 18
        implicitHeight: 18
        Rectangle {
            anchors.centerIn: parent
            anchors.fill: parent
            radius: 4
            color: {
                if(control.checked || control.checkState === Qt.PartiallyChecked){
                    return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
                }
                return Theme.uncheckedInputColor(control,false,false,control.FluentUI.dark)
            }
            border.width: 1
            border.color: {
                if(!control.enabled || control.pressed){
                    return control.FluentUI.theme.res.controlStrongStrokeColorDisabled
                }
                if(control.checked || control.checkState === Qt.PartiallyChecked){
                    return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
                }else{
                    return control.FluentUI.theme.res.controlStrongStrokeColorDefault
                }
            }
        }
        Icon{
            source: FluentIcons.graph_CheckMark
            width: 14
            height: 14
            anchors.centerIn: parent
            color: control.FluentUI.theme.res.textOnAccentFillColorPrimary
            visible: control.checkState === Qt.Checked
        }
        Icon{
            source: FluentIcons.graph_CheckboxIndeterminate
            width: 14
            height: 14
            anchors.centerIn: parent
            color: control.FluentUI.theme.res.textOnAccentFillColorPrimary
            visible: control.checkState === Qt.PartiallyChecked
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
