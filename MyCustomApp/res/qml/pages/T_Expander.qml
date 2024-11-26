import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl
import Gallery

ScrollablePage {

    title: qsTr("Expander")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Expander{
    leading: Label{
        text: "This text is in leading"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
    header: Label{
        text: "This text is in header"
        verticalAlignment: Qt.AlignVCenter
    }
    content: Label{
        text: "This text is in content"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        height: 300
    }
}
`}

}

