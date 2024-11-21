import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Frame {
    id: control
    FluentUI.theme: Theme.of(control)
    FluentUI.radius: 7
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    background: Rectangle {
        radius: control.FluentUI.radius
        color: control.FluentUI.theme.res.scaffoldBackgroundColor
        border.width: 1
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
    }
}
