import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("DropDownButton")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls

DropDownButton{
    text: "DropDownButton"
    MenuItem{
        text: "MenuItem 1"
    }
    MenuSeparator{}
    MenuItem{
        text: "MenuItem 2"
    }
    MenuItem{
        text: "MenuItem 3"
    }
    MenuItem{
        text: "MenuItem 4"
    }
}
`}

}
