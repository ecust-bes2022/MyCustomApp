import QtQuick
import FluentUI.impl

Objects {
    property string appId: "A053D1AE-AEA9-4105-B79C-B5F5BEDC9208"
    property bool singleton: false
    property var locale: Qt.locale()
    signal activeApplicationChanged(string args)
    id: control
    Component.onCompleted: {
        impl.init(control.locale)
        if(control.singleton && Qt.platform.os !== "wasm"){
            impl.checkApplication(control.appId)
        }
    }
    StarterImpl{
        id: impl
        onHandleDataChanged:
            (args)=>{
                control.activeApplicationChanged(args)
            }
    }
}
