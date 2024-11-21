import QtQuick
import FluentUI.impl

FilledButton {
    id: control
    property bool indeterminate: false
    property real value: 0
    readonly property bool completed: control.value === 1
    readonly property bool started: control.value === 0
    readonly property bool ready: control.value !== 0 && control.value !== 1
    contentItem: IconLabel{
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.FluentUI.textColor
        visible: {
            if(control.indeterminate){
                return false
            }
            if(control.ready){
                return false
            }
            return true
        }
    }
    background.implicitWidth: 120
    background.implicitHeight: 30
    ProgressRing{
        id: progress_ring
        width: 20
        height: 20
        strokeWidth: 2
        indeterminate: control.indeterminate
        anchors.centerIn: parent
        value: control.value
        backgroundColor: Colors.withOpacity(control.FluentUI.textColor,0.2)
        activeColor: control.FluentUI.textColor
        visible: {
            if(control.indeterminate || control.ready){
                return true
            }
            return false
        }
    }
    Rectangle{
        width: 8
        height: 8
        radius: 2
        color: control.FluentUI.textColor
        anchors.centerIn: parent
        visible: progress_ring.visible
    }
}
