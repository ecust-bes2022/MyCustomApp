import QtQuick
import QtQuick.Window
import QtQuick.Templates as T
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

T.Menu {
    id: control
    FluentUI.theme: Theme.of(control)
    FluentUI.radius: 7
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    margins: 0
    verticalPadding: 3
    overlap: 10
    focus: false
    transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)
    delegate: MenuItem {}
    enter: Transition {
        NumberAnimation {
            duration: Theme.fastAnimationDuration
        }
    }
    exit: Transition {
        NumberAnimation {
            duration: Theme.fastAnimationDuration
        }
    }
    Item{
        id: d
        property var window: Window.window
    }
    Connections{
        target: d.window
        function onWidthChanged(){
            control.close()
        }
        function onHeightChanged(){
            control.close()
        }
    }
    contentItem: Item{
        implicitHeight: list_content.height
        clip: animationY.running ? true : false
        Rectangle {
            id: layout_list
            width: parent.width
            height: parent.height
            radius: 4
            border.width: 1
            color: control.FluentUI.theme.res.popupBackgroundColor
            border.color: control.FluentUI.theme.res.popupBorderColor
            Shadow{
                radius: 4
            }
            y: 0
            Connections{
                target: control.enter
                function onRunningChanged(){
                    if(control.enter.running){
                        behaviorY.enabled = false
                        layout_list.y = -layout_list.height
                        behaviorY.enabled = true
                        layout_list.y = 0
                    }
                }
            }
            Connections{
                target: control.exit
                function onRunningChanged(){
                    if(control.exit.running){
                        behaviorY.enabled = false
                        layout_list.y = 0
                        behaviorY.enabled = true
                        layout_list.y = -layout_list.height
                    }
                }
            }
            ListView {
                id:list_content
                width: parent.width
                height: Math.min(contentHeight,control.FluentUI.minimumHeight)
                model: control.contentModel
                interactive: Window.window
                             ? contentHeight + control.topPadding + control.bottomPadding > control.height
                             : false
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                currentIndex: control.currentIndex
                ScrollBar.vertical: ScrollBar {}
            }
            Behavior on y{
                id: behaviorY
                NumberAnimation{
                    id: animationY
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
    background: Item{
        implicitWidth: 200
        implicitHeight: 40
    }
    T.Overlay.modal: Rectangle {
        Behavior on opacity { NumberAnimation { duration: 83 } }
    }
    T.Overlay.modeless: Rectangle {
        Behavior on opacity { NumberAnimation { duration: 83 } }
    }
}
