import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item{
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property int overflowCount: 99
    property bool dot: false
    property var dotSize: Qt.size(6,6)
    property bool showZero: false
    property int count: 0
    property color color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    implicitHeight: dot ? rect_dot.height : label_count.height
    implicitWidth: dot ? rect_dot.width : label_count.width
    Label {
        id: label_count
        font: Typography.caption
        color: Colors.white
        leftPadding: 2
        rightPadding: 2
        topPadding: 0
        bottomPadding: 0
        text: {
            if(control.count>overflowCount){
                return `${overflowCount}+`
            }
            return `${control.count}`
        }
        anchors.centerIn: parent
        visible: {
            if(control.dot){
                return false
            }
            if(control.count === 0 && !control.showZero){
                return false
            }
            return true
        }
        width: Math.max(implicitWidth,20)
        horizontalAlignment: Qt.AlignHCenter
        background: Rectangle{
            radius: control.height/2
            color: control.color
        }
    }
    Rectangle{
        id: rect_dot
        width: dotSize.width
        height: dotSize.height
        radius: height/2
        color: control.color
        visible: control.dot
    }
}
