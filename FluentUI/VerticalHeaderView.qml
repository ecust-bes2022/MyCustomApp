import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.VerticalHeaderView {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(1, contentWidth)
    implicitHeight: syncView ? syncView.height : 0
    delegate: Rectangle {
        id: delegate
        required property var model
        readonly property real cellPadding: 8
        implicitWidth: Math.max(control.width, text.implicitWidth + (cellPadding * 2))
        implicitHeight: text.implicitHeight + (cellPadding * 2)
        color: control.FluentUI.theme.res.micaBackgroundColor
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
        Label {
            id: text
            text: delegate.model[control.textRole]
            width: delegate.width
            height: delegate.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
