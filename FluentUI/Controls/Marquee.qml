import QtQuick
import QtQuick.Controls

Item {
    id: control
    property var model
    property int speedFactor: 30
    property string textRole: "title"
    property int currentIndex: 0
    property Component delegate: comp_label
    property font font: Typography.subtitle
    property int layoutDirection: Qt.LeftToRight
    implicitWidth: 400
    implicitHeight: 40
    clip: true
    Component{
        id: comp_label
        Label {
            font: control.font
            text: {
                var data = control.model[currentIndex]
                if(typeof data === "string"){
                    return data
                }
                return data[control.textRole]
            }
        }
    }
    HoverHandler{
        id: hover_handler
        onHoveredChanged: {
            if(hovered){
                anim_scroll.pause()
            }else{
                anim_scroll.resume()
            }
        }
    }
    Loader{
        id: loader_label
        property bool isLeftToRight: control.layoutDirection === Qt.LeftToRight
        property var modelData: control.model[control.currentIndex]
        property int index: control.currentIndex
        sourceComponent: control.delegate
        anchors.verticalCenter: parent.verticalCenter
        onLoaded: {
            anim_scroll.running = true
        }
    }
    SequentialAnimation {
        id: anim_scroll
        PropertyAnimation {
            target: loader_label
            property: "x"
            from: loader_label.isLeftToRight ? -loader_label.width : control.width
            to: loader_label.isLeftToRight ? control.width : -loader_label.width
            duration: control.width * control.speedFactor
        }
        onFinished: {
            control.currentIndex = (control.currentIndex + 1) % model.length
            loader_label.sourceComponent = undefined
            loader_label.sourceComponent = control.delegate
        }
    }
}
