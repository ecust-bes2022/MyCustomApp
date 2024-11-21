import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.HorizontalHeaderView {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: syncView ? syncView.width : 0
    implicitHeight: Math.max(1, contentHeight)
    delegate: Rectangle {
        id: delegate
        required property var model
        readonly property real cellPadding: 8
        implicitWidth: text.implicitWidth + (cellPadding * 2)
        implicitHeight: Math.max(control.height, text.implicitHeight + (cellPadding * 2))
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
