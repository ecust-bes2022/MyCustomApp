import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage{
    title: qsTr("FlipLayout")

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
                FlipLayout {
                    id: flip
                    anchors.fill: parent
                    orientation: combobox.currentValue.orientation
                    Image{
                        source: "qrc:/qt/qml/Gallery/res/image/banner_1.webp"
                        asynchronous: true
                        fillMode:Image.PreserveAspectCrop
                    }
                    Image{
                        source: "qrc:/qt/qml/Gallery/res/image/banner_2.webp"
                        asynchronous: true
                        fillMode:Image.PreserveAspectCrop
                    }
                    Image{
                        source: "qrc:/qt/qml/Gallery/res/image/banner_3.webp"
                        asynchronous: true
                        fillMode:Image.PreserveAspectCrop
                    }
                }
                PageIndicator {
                    anchors.bottom: flip.bottom
                    anchors.bottomMargin: 40
                    anchors.horizontalCenter: flip.horizontalCenter
                    count: flip.count
                    currentIndex: flip.currentIndex
                }
            }
        }
`}

}
