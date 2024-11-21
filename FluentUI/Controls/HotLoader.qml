import QtQuick
import QtQuick.Controls
import FluentUI.impl

AutoLoader{
    id: control
    property var reload: function(){
        var timestamp = Date.now()
        var url = new URL(control.source)
        url.searchParams.set('timestamp', timestamp);
        control.source = url.toString()
    }
    FluentUI.theme: Theme.of(control)
    Component.onDestruction: sourceComponent = undefined
    FileWatcher{
        path: control.source.toString()
        onFileChanged: {
            control.reload()
        }
    }
    Component{
        id: comp_error
        Item{
            Label{
                color: control.FluentUI.theme.res.systemFillColorCritical
                width: parent.width
                horizontalAlignment: Label.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Label.WrapAnywhere
                text: control.sourceComponent.errorString()
            }
        }
    }
    Loader{
        anchors.fill: parent
        sourceComponent: control.status === Loader.Error ? comp_error : undefined
    }
}
