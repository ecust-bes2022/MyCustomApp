import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: control
    property int spacing: 0
    property bool reverse: false
    property int display: Button.TextBesideIcon
    property string text
    property alias icon : d.icon
    property font font: Typography.body
    property Component iconDelegate : comp_icon
    property string family: FluentIcons.fontLoader.name
    property color color: enabled ? Theme.res.textFillColorPrimary : Theme.res.textFillColorDisabled
    implicitWidth: loader.width
    implicitHeight: loader.height
    AutoLoader{
        id: loader
        anchors.centerIn: parent
        sourceComponent: {
            if(display === Button.TextUnderIcon){
                if(reverse){
                    return comp_column_reverse
                }
                return comp_column
            }
            return comp_row
        }
    }
    Action{
        id: d
        icon.width: control.font.pixelSize
        icon.height: control.font.pixelSize
        icon.color: control.color
    }
    Component{
        id: comp_icon
        Icon{
            color: control.icon.color
            source: {
                if(control.icon.source.toString()!==""){
                    return control.icon.source
                }
                return control.icon.name
            }
            width: control.icon.width
            height: control.icon.height
            family: control.family
        }
    }
    Component{
        id: comp_row
        Row{
            layoutDirection: control.reverse ? Qt.RightToLeft : Qt.LeftToRight
            spacing: label_text.text === ""  ? 0 : control.spacing
            AutoLoader{
                sourceComponent: iconDelegate
                visible: control.display !== Button.TextOnly
                anchors.verticalCenter: parent.verticalCenter
            }
            Label{
                id: label_text
                text: control.text
                font: control.font
                color: control.color
                visible: control.display !== Button.IconOnly
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Component{
        id: comp_column
        Column{
            spacing: label_text.text === ""  ? 0 : control.spacing
            AutoLoader{
                sourceComponent: iconDelegate
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label{
                id: label_text
                text: control.text
                font: control.font
                color: control.color
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    Component{
        id: comp_column_reverse
        Column{
            spacing: label_text.text === ""  ? 0 : control.spacing
            Label{
                id: label_text
                text: control.text
                font: control.font
                color: control.color
                anchors.horizontalCenter: parent.horizontalCenter
            }
            AutoLoader{
                sourceComponent: iconDelegate
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
