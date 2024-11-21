import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.ProgressBar {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    contentItem: RoundClip {
        radius: [3,3,3,3]
        Rectangle {
            width: control.position * parent.width
            visible: !control.indeterminate && control.value
            height: parent.height
            radius: 3
            color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        }
        Rectangle{
            visible: control.indeterminate
            width: 0.5 * parent.width
            height: parent.height
            radius: 3
            color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
            SequentialAnimation on x {
                loops: Animation.Infinite
                running: control.indeterminate && control.visible
                NumberAnimation {
                    from: -control.contentItem.width
                    to: control.contentItem.width
                    easing.type: Easing.InOutCubic
                    duration: 1200
                }
                NumberAnimation {
                    from: -control.contentItem.width * 0.5
                    to: control.contentItem.width
                    easing.type: Easing.InOutCubic
                    duration: 750
                }
            }
        }
    }
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 6
        y: (control.height - height) / 2
        height: 6
        radius: 3
        color: control.FluentUI.theme.res.inactiveBackgroundColor
    }
}
