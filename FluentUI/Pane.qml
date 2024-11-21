import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Pane {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    padding: 12
    background: Rectangle {
        color: control.FluentUI.theme.res.micaBackgroundColor
        radius: control.FluentUI.radius
        border.width: 1
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
    }
}
