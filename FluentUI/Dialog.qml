import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Dialog {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))
    padding: 12
    FluentUI.radius: 8
    background: Rectangle {
        color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
        border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
        radius: control.FluentUI.radius
    }
    enter: Transition {
        ParallelAnimation{
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: Theme.fasterAnimationDuration
            }
            NumberAnimation {
                property: "scale"
                from: 0.8
                to: 1.0
                duration: Theme.fastAnimationDuration
            }
        }
    }
    exit: Transition {
        ParallelAnimation{
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: Theme.fasterAnimationDuration
            }
            NumberAnimation {
                property: "scale"
                from: 1.0
                to: 0.8
                duration: Theme.fastAnimationDuration
            }
        }
    }
    header: Label {
        text: control.title
        visible: control.title
        elide: Label.ElideRight
        font: Typography.subtitle
        leftPadding: 12
        rightPadding: 12
        topPadding: 12
        background: Rectangle {
            x: 1; y: 1
            width: parent.width - 2
            height: parent.height - 1
            color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
            radius: control.FluentUI.radius
        }
    }
    footer: DialogButtonBox {
        visible: count > 0
    }
    T.Overlay.modal: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.3)
    }
    T.Overlay.modeless: Rectangle {
        color: Colors.withOpacity(Colors.black, 0.15)
    }
}
