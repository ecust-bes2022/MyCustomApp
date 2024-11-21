import QtQuick
import QtQuick.Controls
import FluentUI.impl

Item {
    id: control
    signal tap
    signal rightTap
    property string title
    property alias icon: d.icon
    property var key
    property bool enabled: true
    property bool __expanded: false
    property var __parent
    property var __index
    property Action __aciton: Action{
        id:d
        icon.width: 16
        icon.height: 16
        icon.color: control.FluentUI.dark ? Colors.white : Colors.black
    }
    property int count: {
        var sum = 0
        for(var i=0;i<children.length;i++){
            var item = children[i]
            if(item instanceof PaneItem || item instanceof PaneItemExpander){
                sum = sum + item.count
            }
        }
        return sum
    }
}
