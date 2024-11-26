import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ContentPage {

    property var sourceData: []
    property var gridData: []

    header: Item{
        width: parent.width
        height: 68
        Label{
            id: label_title
            text: qsTr("Fluent Icons Gallery showcase")
            font: Typography.title
            wrapMode: Label.WrapAnywhere
            maximumLineCount: 2
            elide: Label.ElideRight
            anchors{
                left: parent.left
                leftMargin: 24
                right: textbox_serach.left
                top: parent.top
                topMargin: 24
            }
        }
        TextField{
            id: textbox_serach
            placeholderText: qsTr("Type to filter by name")
            anchors{
                right: parent.right
                rightMargin: 24
                verticalCenter: parent.verticalCenter
            }
            onTextChanged: {
               gridData = sourceData.filter(function(val){ return val.name.toLowerCase().includes(text.toLowerCase())})
            }
        }
    }
    Component.onCompleted: {
        sourceData = FluentIcons.allGrapth()
        gridData = sourceData
    }
    GridView{
        id: grid_view
        cellWidth: 110
        cellHeight: 110
        clip: true
        boundsBehavior: GridView.StopAtBounds
        model: gridData
        ScrollBar.vertical: scroll_bar
        anchors{
            fill: parent
        }
        delegate: Item {
            width: 100
            height: 100
            IconButton{
                id:item_icon
                icon.name: modelData.value
                icon.width: 30
                icon.height: 30
                padding: 0
                verticalPadding: 0
                horizontalPadding: 0
                bottomPadding: 30
                anchors.fill: parent
                onClicked: {
                    var text  ="FluentIcons."+modelData.key
                    Tools.clipText(text)
                    infoBarManager.showSuccess(qsTr("You Copied ")+text)
                }
                Label{
                    width: parent.width
                    horizontalAlignment: Qt.AlignHCenter
                    wrapMode: Text.WrapAnywhere
                    text: modelData.name
                    anchors.top: parent.top
                    anchors.topMargin: 60
                }
            }
        }
    }
    ScrollBar {
        id: scroll_bar
        height: parent.height
        anchors{
            right: parent.right
            rightMargin: -20
        }
    }
}
