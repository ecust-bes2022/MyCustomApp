import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("IconButton")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls

Row{
    spacing: 10
    IconButton{
        text: "IconButton"
    }
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Row{
    spacing: 10
    IconButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
    }
    IconButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
        LayoutMirroring.enabled: true
    }
    IconButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
        display: IconButton.TextUnderIcon
    }
    IconButton{
        text: "Copy"
        icon.source: "qrc:/qt/qml/Gallery/res/image/logo.png"
        width: 40
        height: 40
        icon.width: 18
        icon.height: 18
        display: IconButton.IconOnly
        icon.color: "#00000000"
    }
}
`}

}
