import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("MultiLineTextBox")
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
    TextArea{
        placeholderText: "TextArea"
    }
    MultiLineTextBox{
        placeholderText: "MultiLineTextBox"
    }
    MultiLineTextBox{
        placeholderText: "MultiLineTextBox"
        trailing: IconButton{
            implicitWidth: 30
            implicitHeight: 20
            icon.name: FluentIcons.graph_Search
            icon.width: 14
            icon.height: 14
            padding: 0
        }
    }
    MultiLineTextBox{
        placeholderText: "MultiLineTextBox"
        leading: IconButton{
            implicitWidth: 30
            implicitHeight: 20
            icon.name: FluentIcons.graph_Search
            icon.width: 14
            icon.height: 14
            padding: 0
        }
    }
}`}
}
