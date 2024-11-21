import QtQuick
import FluentUI.impl

Item {
    id:control
    property int radius: 4
    property var target
    anchors.fill: parent
    Rectangle{
        width: control.width
        height: control.height
        anchors.centerIn: parent
        color: "#00000000"
        border.width: 2
        radius: control.radius
        visible: target && target.activeFocus
        border.color: control.FluentUI.dark ? Colors.white : Colors.black
        z: 65535
    }
}
