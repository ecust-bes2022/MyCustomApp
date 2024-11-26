import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ContentPage {

    title: qsTr("SegmentedControl")

    property var colors : [Colors.yellow,Colors.orange,Colors.red,Colors.magenta,Colors.purple,Colors.blue,Colors.teal,Colors.green]

    property var randomAccentColor: function(){
        return colors[Math.floor(Math.random() * 8)]
    }

    ListModel{
        id: tab_model
        ListElement{
            title: "First"
            accentColor: function(){
                return colors[Math.floor(Math.random() * 8)]
            }
        }
        ListElement{
            title: "Second"
            accentColor: function(){
                return colors[Math.floor(Math.random() * 8)]
            }
        }
        ListElement{
            title: "Third"
            accentColor: function(){
                return colors[Math.floor(Math.random() * 8)]
            }
        }
        ListElement{
            title: "Fourth"
            accentColor: function(){
                return colors[Math.floor(Math.random() * 8)]
            }
        }
        ListElement{
            title: "Fifth"
            accentColor: function(){
                return colors[Math.floor(Math.random() * 8)]
            }
        }
    }

    SegmentedControl {
        id: bar
        clip: true
        Repeater {
            model: tab_model
            SegmentedButton {
                id: btn_tab
                text: model.title
            }
        }
    }

    Component{
        id:comp_page
        Frame{
            anchors.fill: parent
            Label{
                font: Typography.titleLarge
                anchors.centerIn: parent
                text: modelData.title
                color: modelData.accentColor().normal
            }
        }
    }

    StackLayout {
        currentIndex: bar.currentIndex
        anchors{
            left: bar.left
            right: bar.right
            top: bar.bottom
            bottom: parent.bottom
            topMargin: 10
        }
        Repeater{
            model:tab_model
            AutoLoader{
                property var modelData: model
                sourceComponent: comp_page
            }
        }
    }

}
