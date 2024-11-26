import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("ToggleSwitch")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 10
    Switch {
        text: "Content"
        checked: true
    }
    Switch {
        text: "Content"
        checked: true
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    Switch {
        text: "Content"
        checked: true
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    Switch {
        text: "Content"
        checked: true
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)

    }
    Switch {
        text: "Content"
        checked: true
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)

    }
    Switch {
        text: "Content"
        checked: true
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
    }
}
`}

}
