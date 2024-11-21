import QtQuick
import FluentUI.impl

Item{
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property int radius: 0
    property url source
    property alias sourceSize: image.sourceSize
    property int borderWidth : 3
    property color borderColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    RoundClip{
        anchors.fill: parent
        radius: [control.radius,control.radius,control.radius,control.radius]
        Image {
            id: image
            anchors.fill: parent
            source: control.source
        }
        Rectangle{
            anchors.fill: parent
            color: Colors.transparent
            border.width: borderWidth
            radius: control.radius
            border.color: borderColor
        }
    }
}
