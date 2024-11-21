import QtQuick

QtObject {
    id: control
    property var routes: ({})
    signal sendRouter(string val,var argument)
    function go(path,argument={}){
        sendRouter(path,argument)
    }
    function toUrl(path){
        var val = routes[path]
        if(!val){
            throw new Error(`Route '${path}' not found!`);
        }
        var url
        if(typeof val === 'string'){
            url = val
        }else if(typeof val === 'object'){
            url = val.url
        }else{
            throw new Error(`Type val is not supported!`);
        }
        return url
    }
}
