import QtQuick
import QtQuick.Controls
import QtQuick.Window
import FluentUI.impl

AutoLoader{
    id:control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property var steps: []
    property int targetMargins: 5
    property int index : 0
    property string finishText: qsTr("Finish")
    property string nextText: qsTr("Next")
    property string previousText: qsTr("Previous")
    property color backgroundColor: control.FluentUI.dark ? Qt.rgba(39/255,39/255,39/255,1) : Qt.rgba(251/255,251/255,253/255,1)
    property var __window : Window.window
    function open(){
        sourceComponent = comp_popup
    }
    Component{
        id: comp_popup
        Popup{
            id: popup
            padding: 0
            width: Overlay.overlay.width
            height: Overlay.overlay.height
            background: Item{}
            contentItem: Item{}
            focus: true
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            parent: __window.contentItem
            Component.onCompleted: {
                control.index = 0
                popup.open()
            }
            Component.onDestruction: {
                control.index = -1
            }
            onClosed: {
                sourceComponent = undefined
            }
            opacity: 0
            enter: Transition {
                SequentialAnimation {
                    PauseAnimation { duration: Theme.mediumAnimationDuration }
                    NumberAnimation {
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: Theme.mediumAnimationDuration
                    }
                }
            }
            exit: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1.0
                    to: 0.0
                    duration: Theme.mediumAnimationDuration
                }
            }
            Item{
                id:d
                property var window: Window.window
                property point pos: Qt.point(0,0)
                property var step: steps[index]
                property var target: {
                    if(step){
                        return step.target()
                    }
                    return undefined
                }
                onTargetChanged: {
                    if(target){
                        d.updateTargetPos()
                        timer_delay.restart()
                    }
                }
                function updateTargetPos(){
                    d.pos = d.target.mapToItem(Overlay.overlay, Qt.point(0, 0))
                    canvas.update()
                }
            }
            Connections{
                id: connect_popup
                target: popup
                enabled: false
                function onWidthChanged(){
                    d.updateTargetPos()
                    timer_delay.restart()
                }
                function onHeightChanged(){
                    d.updateTargetPos()
                    timer_delay.restart()
                }
            }
            Timer{
                id: timer_delay
                interval: 200
                onTriggered: {
                    d.updateTargetPos()
                    connect_popup.enabled = true
                }
            }
            TourBackgroundImpl{
                id: canvas
                anchors.fill: parent
                targetX : d.pos.x-control.targetMargins
                targetY: d.pos.y-control.targetMargins
                targetWidth: {
                    if(!d.target){
                        return 0
                    }
                    return d.target.width+control.targetMargins*2
                }
                targetHeight: {
                    if(!d.target){
                        return 0
                    }
                    return d.target.height+control.targetMargins*2
                }
                Behavior on targetX {
                    NumberAnimation {
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Behavior on targetY {
                    NumberAnimation {
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Behavior on targetWidth {
                    NumberAnimation {
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Behavior on targetHeight {
                    NumberAnimation {
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
            }
            Rectangle{
                id: layout_panne
                radius: 5
                color: control.backgroundColor
                width: 500
                height: childrenRect.height
                property int dir : {
                    if(y<d.pos.y)
                        return 1
                    return 0
                }
                x: {
                    if(d.target){
                        return Math.min(Math.max(0,d.pos.x+d.target.width/2-width/2),popup.width-width)
                    }
                    return 0
                }
                y: {
                    if(d.target){
                        var ty=d.pos.y+d.target.height+control.targetMargins + 15
                        if((ty+height)>popup.height)
                            return d.pos.y-height-control.targetMargins - 15
                        return ty
                    }
                    return 0
                }
                Behavior on x {
                    NumberAnimation {
                        id: anim_farme_x
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        id: anim_farme_y
                        duration: Theme.slowAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Shadow{
                    radius: 5
                }
                Label{
                    text: {
                        if(d.step){
                            return d.step.title
                        }
                        return ""
                    }
                    font: Typography.bodyStrong
                    elide: Text.ElideRight
                    anchors{
                        top: parent.top
                        left: parent.left
                        topMargin: 15
                        leftMargin: 15
                        right: parent.right
                        rightMargin: 32
                    }
                }
                Label{
                    id: text_desc
                    font: Typography.body
                    wrapMode: Text.WrapAnywhere
                    maximumLineCount: 4
                    elide: Text.ElideRight
                    text: {
                        if(d.step){
                            return d.step.description
                        }
                        return ""
                    }
                    anchors{
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        rightMargin: 15
                        topMargin: 42
                        leftMargin: 15
                    }
                }
                StandardButton{
                    id: button_next
                    property bool isLast: {
                        if(d.step){
                            return true === d.step.isLast
                        }
                        return false
                    }
                    text: isLast ? control.finishText : control.nextText
                    onClicked: {
                        if(d.step && d.step.onNextListener){
                            d.step.onNextListener(control)
                        }else{
                            if(isLast){
                                popup.close()
                            }else{
                                if(control.steps.count-1 === control.index){
                                    popup.close()
                                }else{
                                    control.next()
                                }
                            }
                        }
                    }
                    accentColor: control.accentColor
                    highlighted: true
                    anchors{
                        top: text_desc.bottom
                        topMargin: 10
                        right: parent.right
                        rightMargin: 15
                    }
                }
                Button{
                    text: control.previousText
                    visible: control.index !== 0
                    onClicked: {
                        if(d.step && d.step.onPreviousListener){
                            d.step.onPreviousListener(control)
                        }else{
                            control.previous()
                        }
                    }
                    anchors{
                        right: button_next.left
                        top: button_next.top
                        rightMargin: 14
                    }
                }
                IconButton{
                    anchors{
                        right: parent.right
                        top: parent.top
                        margins: 10
                    }
                    width: 26
                    height: 26
                    verticalPadding: 0
                    horizontalPadding: 0
                    icon.width: 12
                    icon.height: 12
                    icon.name: FluentIcons.graph_ChromeClose
                    onClicked: {
                        popup.close()
                    }
                }
                Item{
                    width: parent.width
                    height: 10
                    anchors.top: button_next.bottom
                }
            }
            Icon{
                source: layout_panne.dir?FluentIcons.graph_FlickUp:FluentIcons.graph_FlickDown
                color: control.backgroundColor
                visible: !anim_farme_x.running && !anim_farme_y.running
                x: {
                    if(d.target){
                        return d.pos.x+d.target.width/2-10
                    }
                    return 0
                }
                y: {
                    if(d.target){
                        return d.pos.y+(layout_panne.dir?-height:d.target.height)
                    }
                    return 0
                }
            }
        }
    }
    function next(){
        control.index = Math.min(control.index+1,control.steps.length-1)
    }
    function previous(){
        control.index = Math.max(control.index-1,0)
    }
}
