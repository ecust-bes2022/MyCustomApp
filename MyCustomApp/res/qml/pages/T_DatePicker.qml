import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("DatePicker")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls

DatePicker {

}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: `import QtQuick
import FluentUI.Controls

DatePicker {
    locale: Qt.locale("en_US")
    showYear: true
    showMonth: true
    showDay: true
    startDate: new Date(2000,0,1)
    endDate: new Date(2100,0,1)
}
`}

}
