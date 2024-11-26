import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("CheckBox")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 10
    CheckBox {
        text: "Two-state CheckBox"
        checked: true
    }
    CheckBox {
        text: "Two-state CheckBox"
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
        checked: true
    }
    CheckBox {
        text: "Two-state CheckBox"
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
        checked: true
    }
    CheckBox {
        text: "Two-state CheckBox"
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
        checked: true
    }
    CheckBox {
        text: "Two-state CheckBox"
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
        checked: true
    }
    CheckBox {
        text: "Two-state CheckBox"
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
        checked: true
    }
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls

CheckBox {
    text: "Three-state CheckBox"
    tristate: true
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls

Item{
    height: 100
    ButtonGroup {
        buttons: column.children
    }
    Column {
        id: column
        CheckBox {
            checked: true
            text: qsTr("DAB")
        }
        CheckBox {
            text: qsTr("FM")
        }
        CheckBox {
            text: qsTr("AM")
        }
    }
}
`}
}
