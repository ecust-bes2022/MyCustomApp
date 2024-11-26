import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import Gallery

ContentPage {
    title: qsTr("Watermark")

    ColumnLayout{
        anchors{
            left: parent.left
        }
        RowLayout{
            spacing: 10
            Layout.topMargin: 14
            Label{
                text: "text:"
                Layout.alignment: Qt.AlignVCenter
            }
            TextBox{
                id: text_box
                text: "会磨刀的小猪"
                Layout.preferredWidth: 240
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "textSize:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id: slider_text_size
                value: 20
                from: 13
                to:50
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "gapX:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id:slider_gap_x
                value: 100
                from: 0
                to: 100
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "gapY:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id: slider_gap_y
                value: 100
                from: 0
                to: 100
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "offsetX:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id:slider_offset_x
                value: 50
                from: 0
                to: 100
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "offsetY:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id: slider_offset_y
                value: 50
                from: 0
                to: 100
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "rotate:"
                Layout.alignment: Qt.AlignVCenter
            }
            Slider{
                id: slider_rotate
                value: 22
                from: 0
                to:360
                stepSize: 1
            }
        }
        RowLayout{
            spacing: 10
            Label{
                text: "textColor:"
                Layout.alignment: Qt.AlignVCenter
            }
            ColorPicker{
                id: color_picker
                current: Qt.rgba(0,0,0,0.1)
            }
        }
    }
    Watermark{
        id: water_mark
        anchors.fill: parent
        text:text_box.text
        textColor: color_picker.current
        textSize: slider_text_size.value
        rotate: slider_rotate.value
        gap:Qt.point(slider_gap_x.value,slider_gap_y.value)
        offset: Qt.point(slider_offset_x.value,slider_offset_y.value)
    }
}
