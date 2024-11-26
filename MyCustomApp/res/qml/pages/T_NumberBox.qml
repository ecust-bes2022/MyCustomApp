import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("NumberBox")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls

NumberBox {
    value: 1
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls
import FluentUI.impl

NumberBox {
    placementMode: NumberBoxType.Compact
    placeholderText: "0.00"
    value: 0.00
    smallChange: 0.01
    largeChange: 0.1
    min: 0
    max: 1
}
`}

}
