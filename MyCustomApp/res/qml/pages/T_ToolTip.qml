import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("ToolTip")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

ColumnLayout{
    spacing: 20
    Button {
        text: "Tip Preesed"
        ToolTip.visible: pressed
        ToolTip.text: qsTr("This is a tool tip.")
    }
    IconButton {
        text: "Tip Hovered"
        ToolTip.visible: hovered
        ToolTip.delay: 500
        ToolTip.text: qsTr("This is a tool tip.")
    }
}
`}

}
