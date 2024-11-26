import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("PillButton")
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
    PillButton{
        text: "Pill Button"
        flat: true
    }
    PillButton{
        text: "Pill Button"
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
    }
    PillButton{
        text: "Pill Button"
        highlighted: true
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
    PillButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
    }
    PillButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        spacing: 5
        LayoutMirroring.enabled: true
    }
    PillButton{
        text: "Copy"
        icon.name: FluentIcons.graph_Copy
        icon.width: 18
        icon.height: 18
        width: 60
        height: 60
        spacing: 5
        display: Button.TextUnderIcon
    }
    PillButton{
        text: "Copy"
        icon.source: "qrc:/qt/qml/Gallery/res/image/logo.png"
        width: 40
        height: 40
        icon.width: 18
        icon.height: 18
        display: Button.IconOnly
        icon.color: "#00000000"
    }
}
`}

}
