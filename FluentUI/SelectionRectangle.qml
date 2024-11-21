import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.SelectionRectangle {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    topLeftHandle: Handle {}
    bottomRightHandle: Handle {}
    component Handle : Rectangle {
        id: handle
        property Item handleControl: SelectionRectangle.control
        width: 20
        height: width
        radius: width / 2
        color: control.FluentUI.theme.res.controlSolidFillColorDefault
        Shadow{
            radius: width / 2
        }
        visible: SelectionRectangle.control.active
        Rectangle{
            width: 10
            height: 10
            anchors.centerIn: parent
            radius: width / 2
            scale:{
                if(!handleControl.enabled){
                    return 1
                }
                if(handleControl.pressed){
                    return 0.9
                }
                return handleControl.hovered ? 1.2 : 1
            }
            color: Theme.checkedInputColor(handleControl,control.accentColor,control.FluentUI.dark)
            Behavior on scale{
                NumberAnimation{
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
}
