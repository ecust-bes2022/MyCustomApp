import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl
import Gallery

ContentPage {

    title: qsTr("SyntaxView")

    Component{
        id: qml_highlighter
        QMLHighlighter{}
    }
    ComboBox{
        model: ["QML",  "Text"]
        onCurrentTextChanged: {
            switch(currentText){
            case "QML":
                syntax_view.highlighter = qml_highlighter
                syntax_view.text = qmlText
                break
            default:
                syntax_view.highlighter = null
                break
            }
        }
    }

    readonly property string qmlText : `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

ScrollablePage {

    title: qsTr("Fluent UI for QML Showcase App")

    component RowItem:RowLayout{
        property string title
        property Component leftItem
        property Component rightItem
        spacing: 0
        height: 58
        Item{
            Layout.preferredWidth: 100
            Layout.leftMargin: 30
            Layout.fillHeight: true
            F.Label{
                text: title
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
            }
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Loader{
                anchors.centerIn: parent
                sourceComponent: leftItem
            }
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.theme: Theme.dark ? Material.Dark : Material.Light
            Material.accent: Theme.primaryColor
            Loader{
                anchors.centerIn: parent
                sourceComponent: rightItem
            }
        }
    }
    F.GroupBox {
        id: layout_display_mode
        title: qsTr("NavigationView Display Mode")
        Layout.leftMargin: 30
        Layout.topMargin: 14
        Component.onCompleted: {
            window.tourSteps.push({title:qsTr("NavigationView Display Mode"),description: qsTr("Here you can switch to navigationView display mode."),target:()=>layout_display_mode})
        }
        RowLayout {
            anchors.fill: parent
            Row {
                F.RadioButton {
                    checked: Global.displayMode === NavigationViewType.Top
                    text: qsTr("top")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Top
                    }
                }
                F.RadioButton {
                    checked: Global.displayMode === NavigationViewType.Open
                    text: qsTr("open")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Open
                    }
                }
                F.RadioButton {
                    checked: Global.displayMode === NavigationViewType.Compact
                    text: qsTr("compact")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Compact
                    }
                }
                F.RadioButton {
                    checked: Global.displayMode === NavigationViewType.Minimal
                    text: qsTr("minimal")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Minimal
                    }
                }
                F.RadioButton {
                    checked: Global.displayMode === NavigationViewType.Auto
                    text: qsTr("auto")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Auto
                    }
                }
            }
        }
    }
    ColumnLayout{
        Layout.fillWidth: true
        Layout.leftMargin: 30
        Layout.rightMargin: 30
        spacing: 0
        Row{
            Layout.topMargin: 10
            spacing: 20
            F.Label{
                text: qsTr("Equivalents with the material")
                font: Typography.subtitle
                anchors.verticalCenter: parent.verticalCenter
            }
            F.CheckBox{
                id: checbox_disabled
                text: qsTr("Disabled")
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        ColumnLayout{
            Layout.fillWidth: true
            spacing: 0
            enabled: !checbox_disabled.checked
            RowItem{
                title: qsTr("Button")
                leftItem: F.Button{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                }
                rightItem: Button{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("FilledButton")
                leftItem: F.Button{
                    text: qsTr("Content")
                    highlighted: true
                    anchors.centerIn: parent
                }
                rightItem: Button{
                    text: qsTr("Content")
                    highlighted: true
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("CheckBox")
                leftItem: F.CheckBox{
                    text: qsTr("Content")
                    tristate: true
                    anchors.centerIn: parent
                }
                rightItem: CheckBox{
                    text: qsTr("Content")
                    tristate: true
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("RadioButton")
                leftItem: F.RadioButton{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                    checkable: false
                    onClicked: {
                        checked = !checked
                    }
                }
                rightItem: RadioButton{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                    checkable: false
                    onClicked: {
                        checked = !checked
                    }
                }
            }
            RowItem{
                title: qsTr("ComboBox")
                leftItem: F.ComboBox{
                    model: [qsTr("First"), qsTr("Second"), qsTr("Third")]
                    anchors.centerIn: parent
                }
                rightItem: ComboBox{
                    model: [qsTr("First"), qsTr("Second"), qsTr("Third")]
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("Switch")
                leftItem: F.Switch{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                }
                rightItem: Switch{
                    text: qsTr("Content")
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("Slider")
                leftItem: F.Slider{
                    anchors.centerIn: parent
                }
                rightItem: Slider{
                    anchors.centerIn: parent
                }
            }
            RowItem{
                title: qsTr("ProgressBar")
                id: item_progressbar
                property real value: 0
                leftItem: F.ProgressBar{
                    anchors.centerIn: parent
                    value: item_progressbar.value
                }
                rightItem: ProgressBar{
                    anchors.centerIn: parent
                    value: item_progressbar.value
                }
                PropertyAnimation on value{
                    from: 0
                    to: 1
                    duration: 1000
                    loops: Animation.Infinite
                }
            }
            RowItem{
                title: qsTr("TextField")
                leftItem: F.TextField{
                    anchors.centerIn: parent
                    placeholderText: qsTr("TextField")
                }
                rightItem: TextField{
                    anchors.centerIn: parent
                    placeholderText: qsTr("TextField")
                }
            }
        }
    }
}
`

    SyntaxView{
        id: syntax_view
        anchors{
            topMargin: 40
            fill: parent
        }
        text: qmlText
    }
}
