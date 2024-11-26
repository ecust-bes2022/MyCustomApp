import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("ColorPicker")


    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

Row{
    spacing: 10
    Label{
        text: "Choose Color"
        anchors.verticalCenter: parent.verticalCenter
    }
    ColorPicker{
       anchors.verticalCenter: parent.verticalCenter
    }
}
`}



}
