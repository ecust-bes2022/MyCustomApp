import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Slider")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 10
    Slider{
        value: 0.15
    }
    Slider{
        value: 0.3
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    Slider{
        value: 0.45
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    Slider{
        value: 0.6
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
    }
    Slider{
        value: 0.75
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
    }
    Slider{
        value: 0.9
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
    }
}
`}

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls

Row{
    Slider {
        orientation: Qt.Vertical
    }
    RangeSlider {
        orientation: Qt.Vertical
    }
}

`}
}
