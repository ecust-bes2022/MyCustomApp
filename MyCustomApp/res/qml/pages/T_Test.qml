import QtQuick
import QtQuick.Controls
import FluentUI.Controls

ContentPage {
    title: qsTr("This is a test page")
    Label{
        anchors.centerIn: parent
        text: context.argument.info
        font: Typography.title
    }
}
