import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Label {
    id: control
    FluentUI.theme: Theme.of(control)
    color: control.FluentUI.theme.res.textFillColorPrimary
    linkColor: control.FluentUI.theme.accentColor.defaultBrushFor(control.FluentUI.dark)
    font: Typography.body
    renderType: Theme.textRender
}
