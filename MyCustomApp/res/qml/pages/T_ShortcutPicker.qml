import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ScrollablePage {

    title: qsTr("ShortcutPicker")
    columnSpacing: 14

    RowLayout{
        Layout.topMargin: 24
        Label{
            text: qsTr("Screenshots")
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignVCenter
        }
        ShortcutPicker{
            implicitWidth: 150
            Layout.alignment: Qt.AlignVCenter
            current: ["Alt","A"]
        }
    }
    RowLayout{
        Label{
            text: qsTr("Send Message")
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignVCenter
        }
        ShortcutPicker{
            implicitWidth: 150
            Layout.alignment: Qt.AlignVCenter
            current: ["Enter"]
        }
    }
    RowLayout{
        Label{
            text: qsTr("Open Gallery")
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignVCenter
        }
        ShortcutPicker{
            implicitWidth: 150
            Layout.alignment: Qt.AlignVCenter
            current: ["Ctrl","Alt","W"]
        }
    }
    RowLayout{
        Label{
            text: qsTr("Lock Gallery")
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignVCenter
        }
        ShortcutPicker{
            implicitWidth: 150
            Layout.alignment: Qt.AlignVCenter
            current: ["Ctrl","L"]
        }
    }
}
