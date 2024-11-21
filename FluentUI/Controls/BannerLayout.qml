import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PathView {
    id: control
    property int visibleItemCount: 1
    property int autoPlayDuration: 1500
    property bool autoPlay: true
    property int orientation: Qt.Vertical
    implicitWidth: 400
    implicitHeight: 200
    dragMargin: height / 2
    snapMode: PathView.SnapOneItem
    Path {
        id: path_vertical
        startX: control.width / 2
        startY: -control.height / 2
        PathLine {
            x: control.width / 2
            y: control.pathItemCount * control.height - control.height / 2
        }
    }
    Path {
        id: path_horizontal
        startX: -control.width / 2
        startY: control.height / 2
        PathLine {
            x: control.pathItemCount * control.width - control.width / 2
            y: control.height / 2
        }
    }
    path: control.orientation === Qt.Horizontal ? path_horizontal : path_vertical
    pathItemCount: visibleItemCount + 1
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    clip: true
    Timer {
        id: timer
        running: control.autoPlay
        repeat: true
        interval: control.autoPlayDuration
        onTriggered: control.incrementCurrentIndex()
    }
    onDraggingChanged: {
        if (dragging)
            timer.running = false
        else
            timer.running = control.autoPlay
    }
}
