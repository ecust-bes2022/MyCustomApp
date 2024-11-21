import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.ScrollBar {
    id: control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2
    visible: control.policy !== T.ScrollBar.AlwaysOff && control.size < 1.0
    minimumSize: 0.08
    QtObject{
        id: d
        property color scrollbarColor: control.FluentUI.dark ? "#FFA0A0A0" : "#FF898989"
        property color hoverScrollbarColor: control.FluentUI.dark ? "#FFC0C0C0" : "#FF595959"
        property bool buttonVisible: Number(control.contentItem.implicitWidth) === 6
    }
    verticalPadding : vertical ? padding+12 : padding
    horizontalPadding : horizontal ? padding+12 : padding
    contentItem: Rectangle {
        implicitWidth: 2
        implicitHeight: 2
        radius: width / 2
        color: d.scrollbarColor
        states: State {
            name: "active"
            when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
            PropertyChanges {
                control.contentItem.implicitWidth: 6
                control.contentItem.implicitHeight: 6
            }
        }
        transitions: [
            Transition {
                from: "active"
                SequentialAnimation {
                    PauseAnimation { duration: Theme.slowAnimationDuration }
                    NumberAnimation { target: control.contentItem; duration: Theme.fastAnimationDuration; properties: "implicitWidth,implicitHeight"; to: 2 }
                }
            },
            Transition {
                to: "active"
                SequentialAnimation {
                    PauseAnimation { duration: Theme.fastAnimationDuration }
                    NumberAnimation { target: control.contentItem; duration: Theme.fastAnimationDuration; properties: "implicitWidth,implicitHeight"; to: 6 }
                }
            }
        ]
    }
    background: Rectangle{
        opacity: control.active
        color: control.FluentUI.dark ? "#FF292929" : "#FFF8F8F8"
        radius: 5
        Behavior on opacity {
            NumberAnimation{
                duration: Theme.fastAnimationDuration
            }
        }
    }
    MouseArea{
        width: 8
        height: 8
        visible: d.buttonVisible && control.vertical
        hoverEnabled: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 4
        }
        Icon{
            anchors.fill: parent
            scale: parent.pressed ? 0.85 : 1
            color: parent.containsMouse ? d.hoverScrollbarColor : d.scrollbarColor
            source: FluentIcons.graph_CaretUpSolid8
        }
        onClicked: {
            control.decrease()
        }
    }
    MouseArea{
        width: 8
        height: 8
        visible: d.buttonVisible && control.vertical
        hoverEnabled: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 4
        }
        Icon{
            anchors.fill: parent
            scale: parent.pressed ? 0.85 : 1
            color: parent.containsMouse ? d.hoverScrollbarColor : d.scrollbarColor
            source: FluentIcons.graph_CaretDownSolid8
        }
        onClicked: {
            control.increase()
        }
    }
    MouseArea{
        width: 8
        height: 8
        visible: d.buttonVisible && control.horizontal
        hoverEnabled: true
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 4
        }
        Icon{
            anchors.fill: parent
            scale: parent.pressed ? 0.85 : 1
            color: parent.containsMouse ? d.hoverScrollbarColor : d.scrollbarColor
            source: FluentIcons.graph_CaretLeftSolid8
        }
        onClicked: {
            control.decrease()
        }
    }
    MouseArea{
        width: 8
        height: 8
        visible: d.buttonVisible && control.horizontal
        hoverEnabled: true
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 4
        }
        Icon{
            anchors.fill: parent
            scale: parent.pressed ? 0.85 : 1
            color: parent.containsMouse ? d.hoverScrollbarColor : d.scrollbarColor
            source: FluentIcons.graph_CaretRightSolid8
        }
        onClicked: {
            control.increase()
        }
    }
}
