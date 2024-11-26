import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import FluentUI.Controls
import Gallery

ScrollablePage{

    title: qsTr("QRCode")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls

ColumnLayout{
    QRCode{
        id:qrcode
        size:slider_size.value
        text:text_box.text
        color:color_picker.current
        backgroundColor: bgcolor_picker.current
        margins:slider_margins.value
        Layout.preferredWidth: size
        Layout.preferredHeight: size
    }
    RowLayout{
        spacing: 10
        Layout.topMargin: 20
        Label{
            text:"text:"
            Layout.alignment: Qt.AlignVCenter
        }
        TextBox{
            id:text_box
            text:"会磨刀的小猪"
            Layout.preferredWidth: 240
        }
    }
    RowLayout{
        spacing: 10
        Layout.topMargin: 10
        Label{
            text:"color:"
            Layout.alignment: Qt.AlignVCenter
        }
        ColorPicker{
            id:color_picker
            current: Qt.rgba(0,0,0,1)
        }
    }
    RowLayout{
        spacing: 10
        Layout.topMargin: 10
        Label{
            text:"backgroundColor:"
            Layout.alignment: Qt.AlignVCenter
        }
        ColorPicker{
            id:bgcolor_picker
            current: Qt.rgba(1,1,1,1)
        }
    }
    RowLayout{
        spacing: 10
        Label{
            text:"margins:"
            Layout.alignment: Qt.AlignVCenter
        }
        Slider{
            id:slider_margins
            from:0
            to:80
            stepSize: 1
            value: 0
        }
    }
    RowLayout{
        spacing: 10
        Label{
            text:"size:"
            Layout.alignment: Qt.AlignVCenter
        }
       Slider{
            id:slider_size
            from:120
            to:260
            value: 120
            stepSize: 1
        }
    }
}
`}




}
