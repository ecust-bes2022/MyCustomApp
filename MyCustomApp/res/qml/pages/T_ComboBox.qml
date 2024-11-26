import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("ComboBox")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls

ComboBox{
    model: ["First", "Second", "Third"]
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls

ComboBox{
    model: ListModel {
            id: model
            ListElement { text: "First" }
            ListElement { text: "Second" }
            ListElement { text: "Third" }
    }
    editable: true
    onAccepted: {
         if (find(editText) === -1)
             model.append({text: editText})
     }
}
`}
}
