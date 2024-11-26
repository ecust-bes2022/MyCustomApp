import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ScrollablePage{

    property var colors : [Colors.yellow,Colors.orange,Colors.red,Colors.magenta,Colors.purple,Colors.blue,Colors.teal,Colors.green]

    title: qsTr("TabView")

    Component{
        id:com_page
        Rectangle{
            anchors.fill: parent
            color: argument.normal
        }
    }

    function newTab(){
        tab_view.appendTab("qrc:/qt/qml/Gallery/res/image/logo.png",qsTr("Document ")+tab_view.count(),com_page,colors[Math.floor(Math.random() * 8)])
    }

    Component.onCompleted: {
        newTab()
        newTab()
        newTab()
    }

    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        padding: 10
        RowLayout{
            spacing: 14
            DropDownButton{
                id:btn_tab_width_behavior
                Layout.preferredWidth: 140
                text:"Equal"
                MenuItem{
                    text:"Equal"
                    onClicked: {
                        btn_tab_width_behavior.text = text
                        tab_view.tabWidthBehavior = TabViewType.Equal
                    }
                }
                MenuItem{
                    text:"SizeToContent"
                    onClicked: {
                        btn_tab_width_behavior.text = text
                        tab_view.tabWidthBehavior = TabViewType.SizeToContent
                    }
                }
                MenuItem{
                    text:"Compact"
                    onClicked: {
                        btn_tab_width_behavior.text = text
                        tab_view.tabWidthBehavior = TabViewType.Compact
                    }
                }
            }
            DropDownButton{
                id:btn_close_button_visibility
                text:"Always"
                Layout.preferredWidth: 120
                MenuItem{
                    text:"Never"
                    onClicked: {
                        btn_close_button_visibility.text = text
                        tab_view.closeButtonVisibility = TabViewType.Never
                    }
                }
                MenuItem{
                    text:"Always"
                    onClicked: {
                        btn_close_button_visibility.text = text
                        tab_view.closeButtonVisibility = TabViewType.Always
                    }
                }
                MenuItem{
                    text:"OnHover"
                    onClicked: {
                        btn_close_button_visibility.text = text
                        tab_view.closeButtonVisibility = TabViewType.OnHover
                    }
                }
            }
        }
    }

    Frame{
        Layout.fillWidth: true
        Layout.topMargin: 15
        Layout.preferredHeight: 400
        padding: 10
        TabView{
            id:tab_view
            onNewPressed:{
                newTab()
            }
        }
    }
}
