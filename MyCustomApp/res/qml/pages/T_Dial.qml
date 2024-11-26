import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Dial")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls

Column {
    spacing: 40
    width: parent.width
    Label {
        width: parent.width
        wrapMode: Label.Wrap
        text: qsTr("The Dial is similar to a traditional dial knob that is found on devices such as "
            + "stereos or industrial equipment. It allows the user to specify a value within a range.")
    }
    Dial {
        startAngle: 0
        endAngle: 360
        wrap: true
    }
}
`}

}
