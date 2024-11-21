import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.impl

T.ItemDelegate {
    id: control
    FluentUI.theme: Theme.of(control)
    property Component leading
    property Component trailing
    property Component content: comp_content
    property int radius: 4
    property color textColor: {
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
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    leftPadding: 12
    rightPadding: 12
    spacing: 14
    font: Typography.body
    focusPolicy: Qt.TabFocus
    Component{
        id: comp_content
        Label{
            text: control.text
            font: control.font
            color: control.textColor
            elide: Label.ElideRight
        }
    }
    contentItem: RowLayout{
        spacing: 0
        AutoLoader{
            id: loader_leading
            sourceComponent: leading
        }
        Item{
            implicitHeight: 1
            implicitWidth: visible ? control.spacing : 0
            visible: loader_leading.status === Loader.Ready
        }
        AutoLoader{
            sourceComponent: control.content
            Layout.fillWidth: true
        }
        Item{
            implicitHeight: 1
            implicitWidth: visible ? control.spacing : 0
            visible: loader_trailing.status === Loader.Ready
        }
        AutoLoader{
            id: loader_trailing
            sourceComponent: trailing
        }
    }
    background: FocusItem{
        radius: control.radius
        implicitHeight: 40
        implicitWidth: 100
        target: control
        Rectangle{
            radius: control.radius
            anchors.fill: parent
            color: control.highlighted ? control.FluentUI.theme.res.subtleFillColorSecondary : Theme.uncheckedInputColor(control,true,true,control.FluentUI.dark)
        }
    }
}
