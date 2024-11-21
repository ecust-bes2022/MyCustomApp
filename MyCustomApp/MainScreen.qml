import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

Item{
    Column{
        anchors.centerIn: parent
        spacing: 15
        Image{
            width: 60
            height: 60
            source: "qrc:/qt/qml/MyCustomApp/logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }
    Row{
        anchors{
            bottom: parent.bottom
            bottomMargin: 14
            horizontalCenter: parent.horizontalCenter
        }
        Label{
            text: qsTr("Author's WeChat ID: ")
        }
        Label{
            text: "FluentUI"
        }
    }
}
