import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery


ScrollablePage {

    title: qsTr("RatingControl")
    columnSpacing: 20

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:`import QtQuick
import FluentUI.Controls
import FluentUI.impl

Column{
    spacing: 20
    RatingControl{
    }
    RatingControl{
        value: 1
        FluentUI.primaryColor: Qt.rgba(13/255,110/255,253/255,1)
    }
    RatingControl{
        value: 2
        FluentUI.primaryColor: Qt.rgba(25/255,135/255,84/255,1)
    }
    RatingControl{
        value: 3
        FluentUI.primaryColor: Qt.rgba(220/255,53/255,69/255,1)
    }
    RatingControl{
        value: 4
        FluentUI.primaryColor: Qt.rgba(255/255,193/255,7/255,1)
    }
    RatingControl{
        value: 5
        FluentUI.primaryColor: Qt.rgba(13/255,202/255,240/255,1)
    }
}
`}
    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:`import QtQuick
import FluentUI.Controls

RatingControl {
    number: 10
    value: 5
}
`}
}
