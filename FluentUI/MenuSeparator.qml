import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.MenuSeparator {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    verticalPadding: 2
    contentItem: Rectangle {
        implicitWidth: 200
        implicitHeight: 1
        color: control.FluentUI.theme.res.dividerStrokeColorDefault
    }
}
