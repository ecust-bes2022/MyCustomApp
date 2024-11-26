import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("About")

    Frame{
        Layout.preferredWidth: 260
        Layout.preferredHeight: 200
        ColumnLayout{
            anchors.centerIn: parent
            Image{
                source: "qrc:/qt/qml/Gallery/res/image/logo.png"
                Layout.preferredWidth: 64
                Layout.preferredHeight: 64
                Layout.alignment: Qt.AlignHCenter
            }
            Label{
                text: qsTr("Current version V")+AppInfo.version
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

}
