import QtQuick
import QtQuick.Controls.impl
import FluentUI.impl

StandardButton{
    id: control
    rightPadding: loader_close.width+8
    padding: 4
    font: Typography.caption
    signal closeClicked
    property Component closeButton:Component{
        IconButton{
            id: btn_close
            icon.width: 8
            icon.height: 8
            icon.name: FluentIcons.graph_ChromeClose
            icon.color: control.FluentUI.textColor
            width: 16
            height: 16
            padding: 0
            radius: 8
            backgroundColor: {
                if(!btn_close.enabled){
                    return Theme.buttonColor(btn_close,false,control.FluentUI.dark)
                }else{
                    if(control.highlighted){
                        if(btn_close.pressed){
                            return Theme.lightResource.controlFillColorTertiary
                        }
                        if(btn_close.hovered){
                            return Theme.lightResource.controlFillColorSecondary
                        }
                    }
                    return Theme.uncheckedInputColor(btn_close,true,false,control.FluentUI.dark)
                }
            }
            onClicked: {
                control.closeClicked()
            }
        }
    }
    AutoLoader{
        id: loader_close
        sourceComponent: control.closeButton
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 4
        }
    }
    background.implicitHeight: 20
    background.implicitWidth: 0
}

