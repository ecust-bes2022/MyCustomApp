import QtQuick
import QtQuick.Controls
import FluentUI.impl

Item {
    id: control
    signal tap
    signal rightTap
    property string title
    property Component infoBadge
    property int count: 0
    property var key
    property alias icon: d.icon
    property bool enabled: true
    property bool __footer: false
    property var __parent
    property var __index
    property Action __aciton: Action{
        id:d
        icon.width: 16
        icon.height: 16
        icon.color: control.FluentUI.dark ? Colors.white : Colors.black
    }
}
