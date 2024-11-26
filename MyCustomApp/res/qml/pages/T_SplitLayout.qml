import QtQuick
import QtQuick.Layouts
import FluentUI.Controls
import QtQuick.Controls
import Gallery

ContentPage {
    title: qsTr("SplitLayout")

    ComboBox{
        id: combobox
        currentIndex: 0
        textRole: "text"
        model: ListModel{
            ListElement{
                text: "Horizontal"
                orientation: Qt.Horizontal
            }
            ListElement{
                text: "Vertical"
                orientation: Qt.Vertical
            }
        }
    }

    SplitView {
        id:split_layout
        anchors.fill: parent
        anchors.topMargin: 60
        orientation: combobox.currentValue.orientation
        Item {
            clip: true
            implicitWidth: 200
            implicitHeight: 200
            SplitView.maximumWidth: 400
            SplitView.maximumHeight: 400
            Label {
                text: "Page 1"
                anchors.centerIn: parent
            }
        }
        Item {
            clip: true
            id: centerItem
            SplitView.minimumWidth: 50
            SplitView.minimumHeight: 50
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            Label {
                text: "Page 2"
                anchors.centerIn: parent
            }
        }
        Item {
            clip: true
            implicitWidth: 200
            implicitHeight: 200
            Label {
                text: "Page 3"
                anchors.centerIn: parent
            }
        }
    }
}
