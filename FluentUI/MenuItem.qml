import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.MenuItem {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: 6
    leftPadding: 10
    rightPadding: 10
    spacing: 6
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
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        leftPadding: !control.mirrored ? indicatorPadding : arrowPadding
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignLeft | Qt.AlignVCenter
        icon: control.icon
        text: control.text
        font: control.font
        color: control.FluentUI.textColor
    }
    indicator: Icon {
        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.checkable
        source: FluentIcons.graph_CheckMark
        color: control.checked ? control.accentColor.defaultBrushFor(control.FluentUI.dark) : control.FluentUI.textColor
        width: 16
        height: 16
    }
    arrow: Icon {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.subMenu
        source: control.subMenu ? FluentIcons.graph_ChevronRight : ""
        color: control.FluentUI.textColor
        width: 16
        height: 16
    }
    background: Item{
        implicitWidth: 100
        implicitHeight: 40
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
