import QtQuick
import FluentUI.Controls
import QtQuick.Templates as T
import FluentUI.impl

T.ToolTip {
    id: control
    FluentUI.theme: Theme.of(control)
    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 3
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    margins: 6
    leftPadding: 11
    rightPadding: 11
    topPadding: 8
    bottomPadding: 8
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent
    font: Typography.body
    contentItem: Label {
        text: control.text
        font: control.font
        wrapMode: Text.Wrap
    }
    background: Rectangle {
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
        color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
        radius: control.FluentUI.radius
        Shadow{
            radius: control.FluentUI.radius
        }
    }
}
