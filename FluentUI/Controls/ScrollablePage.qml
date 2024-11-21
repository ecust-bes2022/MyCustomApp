import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ContentPage {
    id: control
    default property alias content: container.data
    property alias flickable: content
    property int columnSpacing: 0
    padding: 0
    topPadding: 24
    leftPadding: 24
    rightPadding: 24
    Flickable{
        id: content
        clip: true
        anchors.fill: parent
        ScrollBar.vertical: scrollbar
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: container.height
        ColumnLayout{
            spacing: control.columnSpacing
            id:container
            width: parent.width
        }
        bottomMargin: 24
    }
    ScrollBar {
        id: scrollbar
        anchors{
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: 4-control.rightPadding
        }
    }
}
