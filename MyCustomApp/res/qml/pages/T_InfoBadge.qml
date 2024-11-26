import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("InfoBadge")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet: `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

RowLayout{
    spacing: 20
    InfoBadge {
        count: 1
    }
    InfoBadge {
        count: 56
    }
    InfoBadge {
        count: 100
    }
    InfoBadge {
        dot: true
    }
    InfoBadge {
        count: 99
        color: "#52c41a"
    }
    InfoBadge {
        count: 0
        color: "#faad14"
        showZero: true
    }
    InfoBadge {
        count: 0
        color: "#52c41a"
    }
}
`}
}
