import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    default property alias content: swipe_view.contentData
    readonly property bool vertical: control.orientation === Qt.Vertical
    property Component decrementItem: comp_decrement
    property Component incrementItem: comp_increment
    property alias orientation: swipe_view.orientation
    property alias count: swipe_view.count
    property alias currentIndex: swipe_view.currentIndex
    SwipeView {
        id: swipe_view
        anchors.fill: parent
        clip: true
    }
    Loader {
        id: loader_decrement
        sourceComponent: swipe_view.currentIndex !== 0 ? control.decrementItem : undefined
        anchors {
            left: parent.left
            leftMargin: 2
            verticalCenter: parent.verticalCenter
            horizontalCenter: undefined
            top: undefined
            topMargin: 0
        }
    }
    Loader {
        id: loader_increment
        sourceComponent: swipe_view.currentIndex !== swipe_view.count - 1 ? control.incrementItem : undefined
        anchors {
            right: parent.right
            rightMargin: 2
            verticalCenter: parent.verticalCenter
            horizontalCenter: undefined
            bottom: undefined
            bottomMargin: 0
        }
    }
    states: State {
        when: control.vertical
        AnchorChanges {
            target: loader_decrement
            anchors {
                left: undefined
                verticalCenter: undefined
                horizontalCenter: parent.horizontalCenter
                top: parent.top
            }
        }
        PropertyChanges {
            target: loader_decrement
            anchors {
                topMargin: 2
                leftMargin: 0
            }
        }
        AnchorChanges {
            target: loader_increment
            anchors {
                right: undefined
                verticalCenter: undefined
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
        }
        PropertyChanges {
            target: loader_increment
            anchors {
                rightMargin: 0
                bottomMargin: 2
            }
        }
    }
    Component {
        id: comp_decrement
        Rectangle {
            height: vertical ? 20 : 40
            width: vertical ? 40 : 20
            radius: 4
            color: Colors.withOpacity(control.FluentUI.theme.res.solidBackgroundFillColorBase, 0.6)
            StandardButton {
                anchors.fill: parent
                FluentUI.radius: parent.radius
                icon.name: vertical ? FluentIcons.graph_CaretUpSolid8 : FluentIcons.graph_CaretLeftSolid8
                icon.width: 8
                icon.height: 8
                onClicked: {
                    control.decrementCurrentIndex()
                }
            }
        }
    }
    Component {
        id: comp_increment
        Rectangle {
            height: vertical ? 20 : 40
            width: vertical ? 40 : 20
            radius: 4
            color: Colors.withOpacity(control.FluentUI.theme.res.solidBackgroundFillColorBase, 0.6)
            StandardButton {
                anchors.fill: parent
                FluentUI.radius: parent.radius
                icon.name: vertical ? FluentIcons.graph_CaretDownSolid8 : FluentIcons.graph_CaretRightSolid8
                icon.width: 8
                icon.height: 8
                onClicked: {
                    control.incrementCurrentIndex()
                }
            }
        }
    }
    WheelHandler {
        onWheel: (event) => {
            if (event.angleDelta.y > 0) {
                control.decrementCurrentIndex()
            } else {
                control.incrementCurrentIndex()
            }
        }
    }
    function decrementCurrentIndex() {
        swipe_view.currentIndex = Math.max(swipe_view.currentIndex - 1, 0)
    }
    function incrementCurrentIndex() {
        swipe_view.currentIndex = Math.min(swipe_view.currentIndex + 1, swipe_view.count - 1)
    }
}
