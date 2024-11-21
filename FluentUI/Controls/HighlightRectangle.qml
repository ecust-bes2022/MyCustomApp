import QtQuick
import FluentUI.impl

Rectangle{
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property int orientation: Qt.Vertical
    property int highlightSize: 18
    property bool highlight
    property int startOffset: d.offset
    property int endOffset: d.offset
    property var target
    property int leftMargin : 0
    property int bottomMargin : 0
    height: d.vertical ? 0 : 3
    width: d.vertical ? 3 : 0
    radius: 1.5
    color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    visible: {
        if(trans_enter.running || trans_start_pop.running || trans_end_pop.running){
            return true
        }
        return highlight
    }
    anchors{
        left: d.vertical ? parent.left : parent.left
        leftMargin: d.vertical ? control.leftMargin : control.startOffset
        top: d.vertical ? parent.top : undefined
        bottom: d.vertical ? parent.bottom : parent.bottom
        topMargin: d.vertical ? control.startOffset : undefined
        bottomMargin: d.vertical ? control.endOffset : control.bottomMargin
        right: d.vertical ? undefined : parent.right
        rightMargin: d.vertical ? 0 : control.endOffset
    }
    state: "normal"
    QtObject{
        id: d
        property bool vertical: control.orientation === Qt.Vertical
        property int offset: vertical ? (control.parent.height - control.highlightSize)/2 : (control.parent.width - control.highlightSize)/2
        onOffsetChanged: {
            control.state = "pop"
        }
    }
    onHighlightChanged: {
        if(highlight){
            var offset = target.currentIndex-target.enterLastIndex
            if(offset>0 && !trans_enter.running){
                control.state = "startEnter"
                control.state = "normal"
            }
            if(offset<0 && !trans_enter.running){
                control.state = "endEnter"
                control.state = "normal"
            }
            target.enterLastIndex = target.currentIndex
        }else{
            offset = target.currentIndex-target.popLastIndex
            if(offset>0 && !trans_enter.running && !trans_end_pop.running){
                control.state = "pop"
                control.state = "endPop"
            }
            if(offset<0 && !trans_enter.running && !trans_start_pop.running){
                control.state = "pop"
                control.state = "startPop"
            }
            target.popLastIndex = target.currentIndex
        }
    }
    states: [
        State{
            name:"endEnter"
            PropertyChanges {
                target: control
                endOffset: 0
                startOffset: d.offset
            }
        },
        State{
            name:"startEnter"
            PropertyChanges {
                target: control
                endOffset: d.offset
                startOffset: 0
            }
        },
        State{
            name:"normal"
            PropertyChanges {
                target: control
                endOffset: d.offset
                startOffset: d.offset
            }
        },
        State{
            name:"endPop"
            PropertyChanges {
                target: control
                endOffset: 0
                startOffset: d.offset
            }
        },
        State{
            name:"startPop"
            PropertyChanges {
                target: control
                endOffset: d.offset
                startOffset: 0
            }
        },
        State{
            name:"pop"
            PropertyChanges {
                target: control
                endOffset: d.offset
                startOffset: d.offset
            }
        }
    ]
    transitions: [
        Transition{
            id: trans_enter
            to: "normal"
            SequentialAnimation{
                PauseAnimation {
                    duration: Theme.fastAnimationDuration
                }
                PropertyAnimation {
                    target: control
                    properties: "startOffset,endOffset"
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        },
        Transition{
            id: trans_end_pop
            to: "endPop"
            onRunningChanged: {
                if(!running){
                    control.endOffset =  d.offset
                    control.startOffset = d.offset
                }
            }
            SequentialAnimation{
                PropertyAnimation {
                    target: control
                    properties: "startOffset,endOffset"
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        },
        Transition{
            id: trans_start_pop
            to: "startPop"
            onRunningChanged: {
                if(!running){
                    control.endOffset =  d.offset
                    control.startOffset = d.offset
                }
            }
            SequentialAnimation{
                PropertyAnimation {
                    target: control
                    properties: "startOffset,endOffset"
                    duration: Theme.fastAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    ]
}
