import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.PageIndicator {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: 6
    spacing: 6
    delegate: Rectangle {
        implicitWidth: 8
        implicitHeight: 8
        radius: width / 2
        color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        opacity: index === control.currentIndex ? 0.95 : pressed ? 0.7 : 0.45
        required property int index
        Behavior on opacity { OpacityAnimator { duration: 100 } }
    }
    contentItem: Row {
        spacing: control.spacing
        Repeater {
            model: control.count
            delegate: control.delegate
        }
    }
}
