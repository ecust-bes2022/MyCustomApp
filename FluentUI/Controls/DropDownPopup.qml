import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.impl

T.Popup{
    id: control
    FluentUI.theme: Theme.of(control)
    required property Component content
    property int offsetY: 3
    property bool animationEnabled: true
    modal: true
    dim: false
    transformOrigin: Item.Top
    verticalPadding: 0
    enter: Transition {
        enabled: control.animationEnabled
        NumberAnimation {
            duration: d.animationDuration
        }
    }
    exit: Transition {
        enabled: control.animationEnabled
        NumberAnimation {
            duration: d.animationDuration
        }
    }
    Item{
        id: d
        property var window: Window.window
        property int animationDuration: control.animationEnabled ? Theme.fastAnimationDuration : 0
    }
    contentItem: Item{
        implicitWidth: control.width
        implicitHeight: control.height
        clip: animationY.running ? true : false
        Shadow{
            radius: 4
        }
        Rectangle {
            id: layout_content
            width: parent.width
            height: parent.height
            radius: 4
            border.width: 1
            color: control.FluentUI.theme.res.popupBackgroundColor
            border.color: control.FluentUI.theme.res.popupBorderColor
            clip: true
            y: 0
            Connections{
                target: control.enter
                function onRunningChanged(){
                    if(control.enter.running){
                        if(control.y>0){
                            behaviorY.enabled = false
                            layout_content.y = -layout_content.height
                            behaviorY.enabled = true
                            layout_content.y = 0
                        }else{
                            behaviorY.enabled = false
                            layout_content.y = layout_content.height
                            behaviorY.enabled = true
                            layout_content.y = 0
                        }
                    }
                }
            }
            Connections{
                target: control.exit
                function onRunningChanged(){
                    if(control.exit.running){
                        if(control.y>0){
                            behaviorY.enabled = false
                            layout_content.y = 0
                            behaviorY.enabled = true
                            layout_content.y = -layout_content.height
                        }else{
                            behaviorY.enabled = false
                            layout_content.y = 0
                            behaviorY.enabled = true
                            layout_content.y = layout_content.height
                        }
                    }
                }
            }
            Loader{
                id: loader_content
                sourceComponent: control.content
                anchors.fill: parent
                clip: true
            }
            Behavior on y{
                id: behaviorY
                NumberAnimation{
                    id: animationY
                    duration: d.animationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
    background: Item{}
    Overlay.modal: Item {}
    function popup(target){
        control.y = Qt.binding(function(){
            if(d.window){
                var pos = target.mapToItem(d.window.contentItem,0, 0)
                if(pos.y+control.height+target.height+control.offsetY<d.window.height){
                    return target.height+control.offsetY
                }else if(pos.y>control.height+control.offsetY){
                    return -control.height-control.offsetY
                }else{
                    return d.window.height-(pos.y+control.height)
                }
            }else{
                return 0
            }
        })
        control.open()
    }
}
