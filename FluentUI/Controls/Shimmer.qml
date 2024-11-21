import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.impl

Item {
    id: control
    clip: true
    FluentUI.theme: Theme.of(control)
    property int duration: 1000
    Rectangle {
        property real offsetX: width*Math.sin(45)
        property color normalColor: Colors.withOpacity(Colors.white,control.FluentUI.dark ? 0.1 : 0.9)
        property color lightColor: Colors.withOpacity(Colors.white,control.FluentUI.dark ? 0.08 : 0.8)
        property color lighterColor: Colors.withOpacity(Colors.white,control.FluentUI.dark ? 0.04 : 0.4)
        z:65535
        id: gradient_rect
        width: control.width/4
        height: Math.sqrt(control.width*control.width+control.height*control.height) + width*2
        transformOrigin: Item.TopLeft
        y: -offsetX
        rotation: 45
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: Colors.transparent }
            GradientStop { position: 0.2; color: gradient_rect.lighterColor }
            GradientStop { position: 0.45; color: gradient_rect.lightColor }
            GradientStop { position: 0.5; color: gradient_rect.normalColor }
            GradientStop { position: 0.55; color: gradient_rect.lightColor }
            GradientStop { position: 0.8; color: gradient_rect.lighterColor }
            GradientStop { position: 1; color: Colors.transparent }
        }
        SequentialAnimation on x {
            loops: Animation.Infinite
            running: control.visible
            NumberAnimation {
                from: -gradient_rect.offsetX
                to: control.width*2+gradient_rect.width+gradient_rect.offsetX
                duration: control.duration
            }
        }
    }
}
