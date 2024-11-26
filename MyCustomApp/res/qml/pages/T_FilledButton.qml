import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("FilledButton")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 20
    FilledButton{
        text: "Filled Button"
    }
    FilledButton{
        text: "Filled Button"
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    FilledButton{
        text: "Filled Button"
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    FilledButton{
        text: "Filled Button"
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
    }
    FilledButton{
        text: "Filled Button"
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
    }
    FilledButton{
        text: "Filled Button"
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
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
    FilledButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
    }
    FilledButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
        LayoutMirroring.enabled: true
    }
    FilledButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
        display: FilledButton.TextUnderIcon
    }
    FilledButton{
        text: "Copy"
        icon.source: "qrc:/qt/qml/Gallery/res/image/logo.png"
        width: 40
        height: 40
        icon.width: 18
        icon.height: 18
        display: FilledButton.IconOnly
        icon.color: "#00000000"
    }
}
`}

}
