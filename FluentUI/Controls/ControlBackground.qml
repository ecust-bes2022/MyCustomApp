import QtQuick
import FluentUI.impl

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    property int radius: 4
    property bool highlighted: false
    property var accentColor: FluentUI.theme.accentColor
    property var target
    property color color: {
        if(control.highlighted){
            if(!control.accentColor){
                return "#00000000"
            }
            if(!target.enabled){
                return control.FluentUI.theme.res.accentFillColorDisabled
            }
            if(target.pressed){
                return control.accentColor.tertiaryBrushFor(control.FluentUI.dark)
            }
            if(target.hovered){
                return control.accentColor.secondaryBrushFor(control.FluentUI.dark)
            }
            return control.accentColor.defaultBrushFor(control.FluentUI.dark)
        }else{
            return Theme.buttonColor(target,false,control.FluentUI.dark)
        }
    }
    RoundClip{
        radius: [control.radius,control.radius,control.radius,control.radius]
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: control.color
        }
    }
    onHighlightedChanged: {
        canvas.update()
    }
    ControlBackgroundImpl{
        id: canvas
        anchors.fill: parent
        radius: control.radius
        defaultColor : target.highlighted ? control.FluentUI.theme.res.controlStrokeColorOnAccentDefault : control.FluentUI.theme.res.controlStrokeColorDefault
        secondaryColor: target.highlighted ? control.FluentUI.theme.res.controlStrokeColorOnAccentSecondary : control.FluentUI.theme.res.controlStrokeColorSecondary
        endColor: target.pressed ? defaultColor : secondaryColor
        borderWidth: 1
        onHeightChanged: {
            canvas.update()
        }
        onWidthChanged: {
            canvas.update()
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
        function onPressedChanged(){
            canvas.update()
        }
    }
}
