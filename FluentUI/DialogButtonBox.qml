import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.DialogButtonBox {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            (control.count === 1 ? implicitContentWidth * 2 : implicitContentWidth) + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    contentWidth: (contentItem as ListView).contentWidth
    spacing: 12
    padding: 12
    alignment: count === 1 ? Qt.AlignRight : undefined
    FluentUI.radius: 8
    property var __highlighted : [DialogButtonBox.AcceptRole,DialogButtonBox.YesRole,DialogButtonBox.ApplyRole]
    delegate: Button {
        width: control.count === 1 ? control.availableWidth / 2 : undefined
        highlighted: __highlighted.indexOf(DialogButtonBox.buttonRole) !== -1
    }
    contentItem: ListView {
        implicitWidth: contentWidth
        model: control.contentModel
        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }
    background: RoundRectangle {
        implicitHeight: 40
        x: 1; y: 1
        width: parent.width - 2
        height: parent.height - 2
        color: control.FluentUI.theme.res.micaBackgroundColor
        radius: [0,0,8,8]
    }
}
