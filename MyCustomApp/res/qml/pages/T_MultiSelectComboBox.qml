import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("MultiSelectComboBox")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

MultiSelectComboBox{
    width: 240
    model: ["CheckBox_1", "CheckBox_2", "CheckBox_3", "CheckBox_4", "CheckBox_5", "CheckBox_6", "CheckBox_7", "CheckBox_8"]
    FluentUI.minimumHeight: 240
    Component.onCompleted: {
        visualModel.items.get(0).inSelected = true
    }
}
`}

}
