import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("RadioButton")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    RadioButton {
        text: "RadioButton"
        checked: true
    }
    RadioButton {
        text: "RadioButton"
        checked: true
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    RadioButton {
        text: "RadioButton"
        checked: true
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    RadioButton {
        text: "RadioButton"
        checked: true
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
    }
    RadioButton {
        text: "RadioButton"
        checked: true
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
    }
    RadioButton {
        text: "RadioButton"
        checked: true
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
    }
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
        RadioButton {
            checked: true
            text: qsTr("DAB")
        }
        RadioButton {
            text: qsTr("FM")
        }
        RadioButton {
            text: qsTr("AM")
        }
    }
}
`}

}
