import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage{
    title: qsTr("BannerLayout")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

ColumnLayout{
    width: parent.width
    ComboBox{
        id: combobox
        currentIndex: 0
        textRole: "text"
        model: ListModel{
            ListElement{
                text: "Horizontal"
                orientation: Qt.Horizontal
            }
            ListElement{
                text: "Vertical"
                orientation: Qt.Vertical
            }
        }
    }
    Item{
        Layout.preferredWidth: 480
        Layout.preferredHeight: 300
        BannerLayout {
            id: banner
            anchors.fill: parent
            orientation: combobox.currentValue.orientation
            model: ListModel {
                ListElement { picUrl: "qrc:/qt/qml/Gallery/res/image/banner_1.webp" }
                ListElement { picUrl: "qrc:/qt/qml/Gallery/res/image/banner_2.webp" }
                ListElement { picUrl: "qrc:/qt/qml/Gallery/res/image/banner_3.webp" }
            }
            delegate: Item {
                width: banner.width
                height: banner.height
                Image {
                    anchors.fill: parent
                    source: picUrl
                }
            }
        }
        PageIndicator {
            anchors.bottom: banner.bottom
            anchors.horizontalCenter: banner.horizontalCenter
            count: banner.count
            currentIndex: banner.currentIndex
        }
    }
}
`}
}
