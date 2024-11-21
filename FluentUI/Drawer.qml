import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Drawer {
    id: control
    FluentUI.theme: Theme.of(control)
    parent: T.Overlay.overlay
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    topPadding: control.edge === Qt.BottomEdge
    leftPadding: control.edge === Qt.RightEdge
    rightPadding: control.edge === Qt.LeftEdge
    bottomPadding: control.edge === Qt.TopEdge
    enter: Transition { SmoothedAnimation { velocity: 5 } }
    exit: Transition { SmoothedAnimation { velocity: 5 } }
    background: Rectangle {
        color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
        Rectangle {
            readonly property bool horizontal: control.edge === Qt.LeftEdge || control.edge === Qt.RightEdge
            width: horizontal ? 1 : parent.width
            height: horizontal ? parent.height : 1
            color: control.FluentUI.theme.res.dividerStrokeColorDefault
            x: control.edge === Qt.LeftEdge ? parent.width - 1 : 0
            y: control.edge === Qt.TopEdge ? parent.height - 1 : 0
        }
    }
    T.Overlay.modal: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.3)
    }
    T.Overlay.modeless: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.15)
    }
}
