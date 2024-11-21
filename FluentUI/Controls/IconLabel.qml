import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.impl

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    property int spacing: 0
    property bool mirrored: false
    property int alignment: Qt.AlignVCenter | Qt.AlignHCenter
    property int display: Button.TextBesideIcon
    property string text
    property alias icon : d.icon
    property font font: Typography.body
    property string family: FluentIcons.fontLoader.name
    property color color: enabled ? control.FluentUI.theme.res.textFillColorPrimary : control.FluentUI.theme.res.textFillColorDisabled
    property real topPadding : 0
    property real leftPadding : 0
    property real rightPadding : 0
    property real bottomPadding : 0
    implicitWidth: loader.width
    implicitHeight: loader.height
    Action{
        id: d
        icon.width: control.font.pixelSize
        icon.height: control.font.pixelSize
        icon.color: control.color
    }
    AutoLoader{
        id: loader
        anchors{
            verticalCenter: (control.alignment & Qt.AlignVCenter) ? control.verticalCenter : undefined
            horizontalCenter: (control.alignment & Qt.AlignHCenter) ? control.horizontalCenter : undefined
        }
        sourceComponent: {
            if(display === Button.TextUnderIcon){
                if(control.mirrored){
                    return comp_column_reverse
                }
                return comp_column
            }
            return comp_row
        }
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
            width: {
                if(source === ""){
                    return 0
                }
                return control.icon.width
            }
            height: {
                if(source === ""){
                    return 0
                }
                return control.icon.height
            }
            family: control.family
        }
    }
    Component{
        id: comp_row
        Item{
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding
            Row{
                layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight
                spacing: label_text.text === ""  ? 0 : control.spacing
                AutoLoader{
                    sourceComponent: comp_icon
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
    }
    Component{
        id: comp_column
        Item{
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding
            Column{
                spacing: label_text.text === ""  ? 0 : control.spacing
                AutoLoader{
                    sourceComponent: comp_icon
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
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
    }
    Component{
        id: comp_column_reverse
        Item{
            width: childrenRect.width + control.leftPadding + control.rightPadding
            height: childrenRect.height + control.topPadding + control.bottomPadding
            x: control.leftPadding
            y: control.topPadding
            Column{
                spacing: label_text.text === ""  ? 0 : control.spacing
                Label{
                    id: label_text
                    text: control.text
                    font: control.font
                    color: control.color
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                AutoLoader{
                    sourceComponent: comp_icon
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
