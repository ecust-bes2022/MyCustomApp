import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Drawer")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

ColumnLayout{
    Drawer {
        id: drawer_left
        width: Overlay.overlay.width * 0.3
        height: Overlay.overlay.height
        edge: Qt.LeftEdge
    }
    Drawer {
        id: drawer_top
        width: Overlay.overlay.width
        height: Overlay.overlay.height * 0.3
        edge: Qt.TopEdge
    }
    Drawer {
        id: drawer_right
        width: Overlay.overlay.width * 0.3
        height: Overlay.overlay.height
        edge: Qt.RightEdge
    }
    Drawer {
        id: drawer_bottom
        width: Overlay.overlay.width
        height: Overlay.overlay.height * 0.3
        edge: Qt.BottomEdge
    }
    ColumnLayout{
        spacing: 10
        RowLayout{
            spacing: 10
            Button{
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("top")
                onClicked: {
                    drawer_top.open()
                }
            }
            Button{
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("right")
                onClicked: {
                    drawer_right.open()
                }
            }
        }
        RowLayout{
            spacing: 10
            Button{
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("bottom")
                onClicked: {
                    drawer_bottom.open()
                }
            }
            Button{
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("left")
                onClicked: {
                    drawer_left.open()
                }
            }
        }
    }
}
`}



}
