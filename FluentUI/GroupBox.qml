import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.GroupBox {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    spacing: 6
    padding: 12
    font: Typography.bodyStrong
    topPadding: padding + (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0)
    label: Label {
        width: control.availableWidth
        text: control.title
        font: control.font
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        radius: control.FluentUI.radius
        color: control.FluentUI.theme.res.scaffoldBackgroundColor
        border.width: 1
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
    }
}
