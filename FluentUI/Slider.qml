import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Slider {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    padding: 6
    focusPolicy: Qt.TabFocus
    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        implicitWidth: 22
        implicitHeight: 22
        radius: width * 0.5
        color: control.FluentUI.theme.res.controlSolidFillColorDefault
        border.width: 1
        border.color: control.FluentUI.theme.res.popupBorderColor
        Shadow{
            radius: width * 0.5
        }
        Rectangle{
            property real diameter: !control.enabled ? 10 : control.pressed ? 8 : control.hovered ? 14 : 10
            width: diameter
            height: diameter
            anchors.centerIn: parent
            radius: diameter * 0.5
            color: Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
            Behavior on diameter {
                NumberAnimation{
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
    background: Item {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 6
        implicitHeight: control.horizontal ? 6 : 200
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight
        FocusItem{
            target: control
            anchors.margins: -10
        }
        Rectangle{
            implicitWidth: control.horizontal ? 200 : 4
            implicitHeight: control.horizontal ? 4 : 200
            width: control.horizontal ? control.availableWidth : implicitWidth
            height: control.horizontal ? implicitHeight : control.availableHeight
            anchors.centerIn: parent
            radius: 2
            color: {
                if(!control.enabled){
                    return control.FluentUI.theme.res.controlStrongFillColorDisabled
                }
                return control.FluentUI.theme.res.controlStrongFillColorDefault
            }
        }
        scale: control.horizontal && control.mirrored ? -1 : 1
        Rectangle {
            y: control.horizontal ? 0 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : 6
            height: control.horizontal ? 6 : control.position * parent.height
            radius: 3
            color: Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
        }
    }
}
