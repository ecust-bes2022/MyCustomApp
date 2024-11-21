import QtQuick
import QtQuick.Controls
import FluentUI.impl

StandardButton {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    property int radius: 4
    property color backgroundColor: {
        if(!control.enabled){
            return Theme.buttonColor(control,false,control.FluentUI.dark)
        }else{
            if(highlighted){
                return Theme.checkedInputColor(control,control.accentColor,control.FluentUI.dark)
            }
            return Theme.uncheckedInputColor(control,true,false,control.FluentUI.dark)
        }
    }
    background: FocusItem{
        implicitHeight: 30
        implicitWidth: 30
        radius: control.radius
        target: control
        Rectangle{
            radius: control.radius
            anchors.fill: parent
            color: control.backgroundColor
        }
    }
}
