import QtQuick
import FluentUI.impl

Item {
    id: control
    property int radius: 4
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property var target
    property var activeColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    property color color: {
        if(!target.enabled){
            return control.FluentUI.theme.res.controlFillColorDisabled
        }
        if(target.activeFocus){
            return control.FluentUI.theme.res.controlFillColorInputActive
        }
        if(target.pressed){
            return control.FluentUI.theme.res.controlFillColorTertiary
        }
        if(target.hovered){
            return control.FluentUI.theme.res.controlFillColorSecondary
        }
        return control.FluentUI.theme.res.controlFillColorDefault
    }
    RoundClip{
        radius: [control.radius,control.radius,control.radius,control.radius]
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: control.color
        }
    }
    Connections{
        target: Theme
        function onDarkChanged(){
            canvas.update()
        }
    }
    Connections{
        target: control.target
        function onActiveFocusChanged(){
            canvas.update()
        }
    }
    InputBackgroundImpl{
        id: canvas
        targetActiveFocus: control.target.activeFocus
        radius: control.radius
        offsetY: targetActiveFocus ? 1 : 0
        defaultColor: control.FluentUI.theme.res.controlStrokeColorDefault
        endColor: {
            if(targetActiveFocus){
                return control.activeColor
            }
            if(target.pressed === true){
                return control.FluentUI.theme.res.controlStrokeColorDefault
            }
           return control.FluentUI.theme.res.controlStrongStrokeColorDefault
        }
        borderWidth: 1
        gradientHeight: targetActiveFocus ? 2 : 3
        anchors.fill: parent
        onHeightChanged: {
            canvas.update()
        }
        onWidthChanged: {
            canvas.update()
        }
    }
}
