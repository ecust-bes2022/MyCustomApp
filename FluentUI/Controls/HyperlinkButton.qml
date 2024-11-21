import QtQuick
import FluentUI.impl

IconButton {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    display: IconButton.TextOnly
    FluentUI.textColor: {
        if(!enabled){
            return control.FluentUI.theme.res.accentFillColorDisabled
        }
        if(pressed){
            return control.accentColor.tertiaryBrushFor(control.FluentUI.dark)
        }
        if(hovered){
            return control.accentColor.secondaryBrushFor(control.FluentUI.dark)
        }
        return control.accentColor.defaultBrushFor(control.FluentUI.dark)
    }
}
