import QtQuick
import FluentUI.impl

Item{
    id: control
    default property alias content: container.data
    property var radius: [0,0,0,0]
    Item{
        id: container
        opacity: 0
        width: control.width
        height: control.height
        layer.enabled: true
    }
    RoundRectangle{
        id: mask_source
        radius: control.radius
        width: control.width
        height: control.height
        visible: false
        layer.enabled: true
    }
    OpacityMask {
        width: control.width
        height: control.height
        source: container
        maskSource: mask_source
    }
}
