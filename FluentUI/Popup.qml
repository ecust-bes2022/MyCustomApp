import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Popup {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    padding: 12
    FluentUI.radius: 8
    background: Rectangle {
        color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
        radius: control.FluentUI.radius
    }
    T.Overlay.modal: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.3)
    }
    T.Overlay.modeless: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.15)
    }
}
