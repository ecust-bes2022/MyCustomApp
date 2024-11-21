import QtQuick
import QtQuick.Controls
import FluentUI.impl

Objects {
    property int edge: Qt.TopEdge
    property var target
    property int offsetX: 20
    property int offsetY: 50
    property int messageMaximumWidth: 520
    id:control
    Objects{
        id:d
        property bool isBottom: (control.edge & Qt.BottomEdge)
        property var screenLayout: null
        function create(severity,title,duration,message,action){
            initScreenLayout()
            screenLayout.append({severity:severity,title:title,duration:duration,message:message,action:action})
        }
        function createCustom(customcomponent,duration){
            initScreenLayout()
            screenLayout.append({customcomponent:customcomponent,duration:duration})
        }
        function initScreenLayout(){
            if(screenLayout == null){
                screenLayout = comp_list.createObject(control.target)
                screenLayout.z = 65535
            }
        }
        Component{
            id: comp_list
            Item{
                id: info_control
                parent: target
                z: 65535
                anchors.fill: target
                ListModel{
                    id: data_model
                    dynamicRoles: true
                    onCountChanged: {
                        if(count === 0){
                            info_control.destroy()
                        }
                    }
                }
                Component{
                    id: comp_infobar
                    InfoBar{
                        id: info_bar
                        property var __model: model
                        severity: model.severity
                        title: model.title
                        message: model.message
                        closable: model.duration <= 0
                        action: Loader{
                            property var model: info_bar.__model
                            property var infoControl: info_control
                            sourceComponent: model.action
                        }
                        messageMaximumWidth: control.messageMaximumWidth
                        onClickCloseListener: function(){
                            info_control.remove(model.index)
                        }
                    }
                }
                ListView{
                    spacing: 20
                    anchors.fill: parent
                    anchors.topMargin: d.isBottom ? 0 : control.offsetY
                    anchors.bottomMargin: d.isBottom ? control.offsetY : 0
                    interactive: false
                    verticalLayoutDirection: d.isBottom ? ListView.BottomToTop : ListView.TopToBottom
                    displaced: Transition {
                        ParallelAnimation{
                            NumberAnimation{
                                duration: Theme.fastAnimationDuration
                                properties: "x,y"
                                easing.type: Theme.animationCurve
                            }
                        }
                    }
                    delegate: Item{
                        id: item_layout
                        property var __model: model
                        implicitWidth: ListView.view.width
                        implicitHeight: loader_content.height
                        Shadow{
                            radius: 4
                            anchors.fill: loader_content
                            elevation: 3
                        }
                        ListView.onAdd:{
                            if(control.edge & Qt.LeftEdge){
                                add_animation_left.start()
                            }else if(control.edge & Qt.RightEdge){
                                add_animation_right.start()
                            }else{
                                add_animation.start()
                            }
                        }
                        SequentialAnimation {
                            id: add_animation
                            NumberAnimation{
                                target: loader_content
                                property: "y"
                                from: -loader_content.height
                                to: 0
                                duration: Theme.fastAnimationDuration
                                easing.type: Theme.animationCurve
                            }
                        }
                        SequentialAnimation {
                            id: add_animation_left
                            NumberAnimation{
                                target: loader_content
                                property: "anchors.leftMargin"
                                from: -loader_content.width
                                to: control.offsetX
                                duration: Theme.fastAnimationDuration
                                easing.type: Theme.animationCurve
                            }
                        }
                        SequentialAnimation {
                            id: add_animation_right
                            NumberAnimation{
                                target: loader_content
                                property: "anchors.rightMargin"
                                from: -loader_content.width
                                to: control.offsetX
                                duration: Theme.fastAnimationDuration
                                easing.type: Theme.animationCurve
                            }
                        }
                        AutoLoader{
                            id: loader_content
                            property var model: item_layout.__model
                            property var infoControl: info_control
                            sourceComponent: {
                                if(model.customcomponent){
                                    return model.customcomponent
                                }
                                return comp_infobar
                            }
                            anchors {
                                left: (control.edge & Qt.LeftEdge) ? parent.left : undefined
                                right: (control.edge & Qt.RightEdge) ? parent.right : undefined
                                horizontalCenter: (control.edge === Qt.TopEdge) || (control.edge === Qt.BottomEdge) ? parent.horizontalCenter : undefined
                            }
                            anchors.leftMargin: control.offsetX
                            anchors.rightMargin: control.offsetX
                        }
                        Timer {
                            id:delay_timer
                            interval: model.duration
                            running: model.duration > 0
                            repeat: model.duration > 0
                            onTriggered: {
                                info_control.remove(model.index)
                            }
                        }
                    }
                    model: data_model
                }
                function append(data){
                    data_model.append(data)
                }
                function remove(index){
                    if(index>=0 && index<data_model.count){
                        data_model.remove(index)
                    }
                }
            }
        }
    }
    function showSuccess(title,duration=1500,message,action){
        return d.create(InfoBarType.Success,title,duration,message ? message : "",action ? action : null)
    }
    function showInfo(title,duration=1500,message,action){
        return d.create(InfoBarType.Info,title,duration,message ? message : "",action ? action : null)
    }
    function showWarning(title,duration=1500,message,action){
        return d.create(InfoBarType.Warning,title,duration,message ? message : "",action ? action : null)
    }
    function showError(title,duration=1500,message,action){
        return d.create(InfoBarType.Error,title,duration,message ? message : "",action ? action : null)
    }
    function show(type,title,duration=1500,message,action){
        return d.create(type,title,duration,message ? message : "",action ? action : null)
    }
    function showCustom(customcomponent,duration=1500){
        return d.createCustom(customcomponent,duration)
    }
    function clearAllInfo(){
        if(d.screenLayout != null) {
            d.screenLayout.destroy()
            d.screenLayout = null
        }
        return true
    }
}
