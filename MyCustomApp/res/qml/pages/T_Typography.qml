import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls


ContentPage {

    property real textScale: 1
    title: qsTr("Typography showcase")

    ColumnLayout{
        spacing: 0
        scale: textScale
        transformOrigin: Item.TopLeft
        anchors{
            left: parent.left
            top: parent.top
        }
        Label{
            text:"Display"
            padding: 0
            font: Typography.display
        }
        Label{
            text:"Title Large"
            padding: 0
            font: Typography.titleLarge
        }
        Label{
            text:"Title"
            padding: 0
            font: Typography.title
        }
        Label{
            text:"Subtitle"
            padding: 0
            font: Typography.subtitle
        }
        Label{
            text:"Body Large"
            padding: 0
            font: Typography.bodyLarge
        }
        Label{
            text:"Body Strong"
            padding: 0
            font: Typography.bodyStrong
        }
        Label{
            text:"Body"
            padding: 0
            font: Typography.body
        }
        Label{
            text:"Caption"
            padding: 0
            font: Typography.caption
        }
    }

    Slider{
        id:slider
        orientation: Qt.Vertical
        anchors{
            right: parent.right
            top: parent.top
        }
        onValueChanged:{
            textScale = 1+value
        }
    }

}
