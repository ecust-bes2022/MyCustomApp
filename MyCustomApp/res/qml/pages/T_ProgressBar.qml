import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("ProgressBar")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 20
    ProgressBar{
        indeterminate: true
    }
    ProgressBar{
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
        indeterminate: true
    }
    ProgressBar{
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
        indeterminate: true
    }
    ProgressBar{
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
        indeterminate: true
    }
    ProgressBar{
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
        indeterminate: true
    }
    ProgressBar{
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
        indeterminate: true
    }
}
`}

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import FluentUI.Controls
import QtQuick.Controls

Row{
    height: 60
    spacing: 10
    ProgressBar{
        from: 0
        to: 1
        value: number.value
        anchors.verticalCenter: parent.verticalCenter
    }
    NumberBox {
        id: number
        placeholderText: "0.00"
        value: 0.00
        smallChange: 0.01
        largeChange: 0.1
        min: 0
        max: 1
        anchors.verticalCenter: parent.verticalCenter
    }
}
`}


}
