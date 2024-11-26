import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("DelayButton")
    columnSpacing: 24


    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    width: parent.width
    spacing: 20
    Label {
        width: parent.width
        wrapMode: Label.Wrap
        text: qsTr("DelayButton is a checkable button that incorporates a delay before the "
            + "button is activated. This delay prevents accidental presses.")
    }
    DelayButton {
        text: qsTr("DelayButton")
    }
}
`}



}
