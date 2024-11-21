import QtQuick

Item {
    id:control
    visible: false
    property var __from : Window.window
    property var __to
    property var path
    signal result(var data)
    function launch(argument = {}){
        WindowRouter.go(control.path,argument,control)
    }
    function setResult(data = {}){
        control.result(data)
    }
}
