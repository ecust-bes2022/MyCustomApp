import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("TimePicker")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls

TimePicker {

}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls

TimePicker {
    locale: Qt.locale("en_US")
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls
import FluentUI.impl

TimePicker {
    hourFormat: TimePickerType.HH
    minuteIncrement: 5
}
`}
}
