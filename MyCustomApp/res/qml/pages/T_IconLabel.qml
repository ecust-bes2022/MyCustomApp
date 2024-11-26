import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("IconLabel")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:`import QtQuick
import FluentUI.Controls
import QtQuick.Controls.impl as I

Row{
    spacing: 60
    IconLabel {
        icon.name: FluentIcons.graph_Copy
        text: "Copy"
        icon.width: 16
        icon.height: 16
        spacing: 10
    }
    I.IconLabel {
        icon.name: FluentIcons.graph_Copy
        text: "Copy"
        icon.width: 16
        icon.height: 16
        spacing: 10
    }
}
`
    }

}
