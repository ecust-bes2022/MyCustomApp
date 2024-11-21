import QtQuick
import QtQuick.Controls
import FluentUI.impl

TextEdit {
    id:control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    color: control.FluentUI.theme.res.textFillColorPrimary
    readOnly: true
    renderType: Theme.textRender
    padding: 0
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    selectByMouse: true
    selectionColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    selectedTextColor: Colors.basedOnLuminance(selectionColor)
    bottomPadding: 0
    font: Typography.body
    TapHandler{
        acceptedButtons: Qt.RightButton
        onTapped: {
            menu.popup()
        }
    }
    InputMenu{
        id: menu
        targetItem: control
    }
}
