import QtQuick
import QtQuick.Controls.impl
import FluentUI.impl

Item{
    id: control
    FluentUI.theme: Theme.of(control)
    property var source
    property var color: control.FluentUI.dark ? Colors.white : Colors.black
    property string family: FluentIcons.fontLoader.name
    implicitWidth: 24
    implicitHeight: 24
    Component{
        id: comp_text
        Text{
            font.family: control.family
            text: control.source
            font.pixelSize: control.width
            color: control.color
        }
    }
    Component{
        id: comp_image
        Item{
            ColorImage{
                id: image_icon
                anchors.fill: parent
                source: control.source
                sourceSize: Qt.size(width,height)
                color: control.color
            }
        }
    }
    AutoLoader {
        anchors.fill: parent
        sourceComponent: {
            if(control.source){
                if(Tools.isUrl(control.source)){
                    return comp_image
                }
                return comp_text
            }
            return undefined
        }
    }
}

