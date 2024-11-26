import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("CopyableText")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:`import QtQuick
import FluentUI.Controls

CopyableText {
    text: "This is a piece of text that can be copied"
}
`
    }

}
