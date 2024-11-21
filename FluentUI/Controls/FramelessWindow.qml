import QtQuick
import QtQuick.Controls
import FluentUI.impl

Window {
    id: control
    FluentUI.theme: Theme.of(control)
    required property var initialItem
    property alias containerItem: layout_container
    property alias framelessHelper: frameless
    property int launchMode: WindowType.Standard
    property bool fitsAppBarWindows: false
    property bool topmost: false
    property bool fixSize: false
    property AppBar appBar: AppBar{
        showMaximize: !control.fixSize
        windowTitle: control.title
    }
    property int __margins: 0
    property var __windowRegister
    property string __route
    property Component background: comp_background
    property bool autoDestroy: true
    property int windowEffect: WindowEffectType.Normal
    signal init(var argument)
    signal newInit(var argument)
    FluentUI.dark: Theme.dark
    FluentUI.primaryColor: Theme.primaryColor
    property var onCloseListener: function(event){
        if(autoDestroy){
            WindowRouter.removeWindow(control)
        }else{
            control.hide()
            event.accepted = false
        }
    }
    color: {
        if(Qt.platform.os === "windows"){
            return Colors.transparent
        }
        return control.FluentUI.theme.res.micaBackgroundColor
    }
    Component.onCompleted: {
        WindowRouter.addWindow(control)
        if(appBar && Number(appBar.width) === 0){
            appBar.width = Qt.binding(function(){ return control.width })
        }
    }
    Component.onDestruction: {
        frameless.onDestruction()
    }
    Component{
        id: comp_background
        Rectangle{
            color: {
                if(Qt.platform.os === "windows" && windowEffect !== WindowEffectType.Normal && Tools.isWindows11OrGreater()){
                    return Colors.transparent
                }
                return control.FluentUI.theme.res.micaBackgroundColor
            }
        }
    }
    Connections{
        target: control
        function onClosing(event){onCloseListener(event)}
    }
    AutoLoader{
        anchors.fill: parent
        sourceComponent: control.background
    }
    Frameless{
        id: frameless
        appbar: control.appBar
        topmost: control.topmost
        fixSize: control.fixSize
        buttonMaximized: control.appBar.buttonMaximized
        dark: control.FluentUI.dark
        windowEffect: control.windowEffect
    }
    Item{
        id: layout_container
        anchors.fill: parent
        anchors.margins: __margins
        HotLoader{
            id: loader_container
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            anchors{
                fill: parent
                topMargin: fitsAppBarWindows ? 0 : layout_appbar.height
            }
            source: {
                if(control.initialItem){
                    return control.initialItem
                }
                return ""
            }
        }
        Item{
            id: layout_appbar
            data: [appBar]
            width: parent.width
            height: childrenRect.height
            visible: !frameless.disabled
            y: control.visibility === Window.FullScreen ? -childrenRect.height : 0
            Behavior on y {
                NumberAnimation{
                    duration: Theme.slowAnimationDuration
                    easing.type: Theme.animationCurve
                }
            }
        }
    }
    function setHitTestVisible(id){
        frameless.setHitTestVisible(id)
    }
    function showMaximized(){
        frameless.showMaximized()
    }
    function showMinimized(){
        frameless.showMinimized()
    }
    function showNormal(){
        frameless.showNormal()
    }
    function showFullScreen(){
        frameless.showFullScreen()
    }
    function deleteLater(){
        Tools.deleteLater(control)
    }
    function setResult(data){
        if(__windowRegister){
            __windowRegister.setResult(data)
        }
    }
}
