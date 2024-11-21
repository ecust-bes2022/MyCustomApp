import QtQuick
import QtQuick.Controls
import FluentUI.impl

StackView {
    id: control
    property PageRouter router
    property bool skipCurrentCheck: false
    QtObject{
        id: d
        property var singletonMap: ({})
    }
    Connections{
        target: control.router
        function onSendRouter(path,argument){
            if(!control.skipCurrentCheck && currentItem && currentItem.path === path){
                return
            }
            var val = control.router.routes[path]
            if(!val){
                throw new Error(`Route '${path}' not found!`);
            }
            var url
            var singleton
            if(typeof val === 'string'){
                url = val
            }else if(typeof val === 'object'){
                url = val.url
                singleton = val.singleton
            }else{
                throw new Error(`Type val is not supported!`);
            }
            if(!singleton){
                singleton = false
            }
            var args = {path:path,url:url,argument:argument,singleton:singleton}
            if(singleton){
                var item
                if(path in d.singletonMap){
                    item = d.singletonMap[path]
                }else{
                    item = comp_panne.createObject(control,args)
                    d.singletonMap[path] = item
                }
                args.singletonItem = item
                control.push(comp_panne_singleton,args)
            }else{
                control.push(comp_panne,args)
            }
        }
    }
    Component{
        id: comp_panne_singleton
        Item{
            property string title: singletonItem.title
            property var path
            property var url
            property var argument
            property bool singleton
            property var singletonItem
            data: [singletonItem]
            StackView.onActivated: {
                singletonItem.__context.activated()
            }
            StackView.onDeactivated: {
                singletonItem.__context.deactivated()
            }
            onVisibleChanged: {
                if(visible){
                    data = [singletonItem]
                    this.updateLayout()
                }
            }
            Component.onCompleted: {
                this.updateLayout()
            }
            function updateLayout(){
                singletonItem.width = Qt.binding(function(){return width})
                singletonItem.height = Qt.binding(function(){return height})
            }
        }
    }
    Component{
        id: comp_panne
        HotLoader{
            id: loader_panne
            property string title
            property var path
            property var url
            property var argument
            property bool singleton
            property var stackView: control
            property var pageRouter: control.router
            property alias __context: context
            property var __current:{
                if(singleton){
                    return url
                }
                return visible ? url : ""
            }
            on__CurrentChanged: {
                loader_panne.setSource(__current,{context:context})
            }
            reload: function(){
                var timestamp = Date.now()
                var url = new URL(__current)
                url.searchParams.set('timestamp', timestamp);
                loader_panne.setSource(url.toString(),{context:context})
            }
            StackView.onActivated: {
                context.activated()
            }
            StackView.onDeactivated: {
                context.deactivated()
            }
            PageContext{
                id: context
                path: loader_panne.path
                url: loader_panne.url
                argument: loader_panne.argument
                singleton: loader_panne.singleton
                view: loader_panne.stackView
                router: loader_panne.pageRouter
            }
            onLoaded: {
                loader_panne.title = loader_panne.item.title
            }
        }
    }
}
