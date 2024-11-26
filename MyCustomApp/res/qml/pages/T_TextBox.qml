import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("TextBox")
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
    TextField{
        placeholderText: "TextField"
    }
    TextBox{
        placeholderText: "TextBox"
    }
    TextBox{
        placeholderText: "TextBox"
        trailing: IconButton{
            implicitWidth: 30
            implicitHeight: 20
            icon.name: FluentIcons.graph_Search
            icon.width: 14
            icon.height: 14
            padding: 0
        }
    }
    TextBox{
        placeholderText: "TextBox"
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
