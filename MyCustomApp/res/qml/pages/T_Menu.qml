import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Menu")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

ColumnLayout{
    width: parent.width
    Menu {
        id:menu
        width: 140
        title: qsTr("File")
        Action { text: qsTr("New...")}
        Action { text: qsTr("Open...") }
        Action { text: qsTr("Save") }
        MenuSeparator { }
        MenuItem{
            text: qsTr("Quit")
        }
        MenuItem{
            text: qsTr("Search")
            icon.name: FluentIcons.graph_Zoom
            icon.width: 14
            icon.height: 14
        }
        Action {
            text: qsTr("Disable")
            enabled:false
        }
        MenuSeparator { }
        Action { text: qsTr("Check");checkable: true;checked: true}
        Menu{
            width: 140
            title: qsTr("Save As...")
            Action { text: qsTr("Doc") }
            Action { text: qsTr("PDF") }
        }
    }
    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 100
        padding: 10
        Column{
            id: layout_column
            spacing: 15
            anchors{
                verticalCenter: parent.verticalCenter
                left:parent.left
            }
            Label{
                text: qsTr("Menu")
            }
            Button{
                text: qsTr("Show Menu Popup")
                Layout.topMargin: 20
                onClicked:{
                    menu.popup()
                }
            }
        }
    }
    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 100
        padding: 10
        Layout.topMargin: 20
        Column{
            spacing: 15
            anchors{
                verticalCenter: parent.verticalCenter
                left:parent.left
            }
            Label{
                text: qsTr("MenuBar")
            }
            MenuBar {
                id:menu_bar
                Menu {
                    width: 140
                    title: qsTr("File")
                    Action { text: qsTr("New...") }
                    Action { text: qsTr("Open...") }
                    Action { text: qsTr("Save") }
                    MenuSeparator { }
                    Action { text: qsTr("Quit") }
                    Action {
                        text: qsTr("Disable")
                        enabled:false
                    }
                    Menu{
                        width: 140
                        title: qsTr("Save As...")
                        Action { text: qsTr("Doc") }
                        Action { text: qsTr("PDF") }
                    }
                }
                Menu {
                    width: 140
                    title: qsTr("Edit")
                    Action { text: qsTr("Cut") }
                    Action { text: qsTr("Copy") }
                    Action { text: qsTr("Paste") }
                }
                Menu {
                    width: 140
                    title: qsTr("Help")
                    Action { text: qsTr("About") }
                }
            }
        }
    }
}
`}

}
