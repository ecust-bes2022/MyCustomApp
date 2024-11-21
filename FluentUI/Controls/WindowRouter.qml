pragma Singleton

import QtQuick
import FluentUI.impl

QtObject {
    property var routes : ({})
    property var windows: []
    function addWindow(window){
        if(!window.transientParent){
            windows.push(window)
        }
    }
    function removeWindow(win) {
        if(!win.transientParent){
            var index = windows.indexOf(win)
            if (index !== -1) {
                windows.splice(index, 1)
                win.deleteLater()
            }
        }
    }
    function exit(retCode){
        for(var i =0 ;i< windows.length; i++){
            var win = windows[i]
            win.deleteLater()
        }
        windows = []
        Qt.exit(retCode)
    }
    function go(route,argument={},windowRegister = undefined){
        if(!routes.hasOwnProperty(route)){
            console.error("Not Found Route",route)
            return
        }
        var windowComponent = Qt.createComponent(routes[route])
        if (windowComponent.status !== Component.Ready) {
            console.error(windowComponent.errorString())
            return
        }
        var properties = {}
        properties.__route = route
        if(windowRegister){
            properties.__windowRegister = windowRegister
        }
        var win = undefined
        for(var i =0 ;i< windows.length; i++){
            var item = windows[i]
            if(route === item.__route){
                win = item
                break
            }
        }
        if(win){
            var launchMode = win.launchMode
            if(launchMode === WindowType.SingleInstance){
                win.newInit(argument)
                win.show()
                if(win instanceof FramelessWindow){
                    win.topmost = !win.topmost
                    win.topmost = !win.topmost
                }else{
                    win.raise()
                }
                win.requestActivate()
                return
            }else if(launchMode === WindowType.SingleTask){
                win.close()
            }
        }
        win = windowComponent.createObject(null,properties)
        win.init(argument)
        if(windowRegister){
            windowRegister.__to = win
        }
    }
}
