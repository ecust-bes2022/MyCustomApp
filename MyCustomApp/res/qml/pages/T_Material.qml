pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl
import QtQuick.Controls.Material as M
import Gallery

ScrollablePage {
    id: page
    header: Item{}
    title: qsTr("FluentUI Pro")
    Connections{
        target: context
        function onActivated() {
            console.debug("Material","onActivated")
        }
        function onDeactivated() {
            console.debug("Material","onDeactivated")
        }
    }
    Button{
        Layout.preferredHeight: 68
        Layout.fillWidth: true
        Label{
            text: qsTr("This is a subpage of StackPage")
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
        }
        Icon{
            source: FluentIcons.graph_ChevronRight
            width: 20
            height: 20
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 20
            }
        }
        onClicked: {
            context.router.go("/subpage")
        }
    }

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
            Label{
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
            Loader{
                anchors.centerIn: parent
                sourceComponent: rightItem
            }
        }
    }
    GroupBox {
        id: layout_display_mode
        title: qsTr("NavigationView Display Mode")
        Layout.topMargin: 20
        RowLayout {
            anchors.fill: parent
            Row {
                RadioButton {
                    checked: Global.displayMode === NavigationViewType.Top
                    text: qsTr("top")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Top
                    }
                }
                RadioButton {
                    checked: Global.displayMode === NavigationViewType.Open
                    text: qsTr("open")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Open
                    }
                }
                RadioButton {
                    checked: Global.displayMode === NavigationViewType.Compact
                    text: qsTr("compact")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Compact
                    }
                }
                RadioButton {
                    checked: Global.displayMode === NavigationViewType.Minimal
                    text: qsTr("minimal")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Minimal
                    }
                }
                RadioButton {
                    checked: Global.displayMode === NavigationViewType.Auto
                    text: qsTr("auto")
                    onClicked: {
                        Global.displayMode = NavigationViewType.Auto
                    }
                }
            }
        }
    }

    Pane{
        id: layout_pane
        Layout.fillWidth: true
        Layout.preferredHeight: layout_column.height + 20
        Layout.topMargin: 10
        FluentUI.dark: checbox_dark.checked
        FluentUI.primaryColor: Colors.blue
        M.Material.accent: FluentUI.theme.accentColor.normal
        M.Material.theme: checbox_dark.checked ? M.Material.Dark : M.Material.Light

        ListModel{
            id: accentColors
            ListElement{
                name: "Yellow"
                color: function(){return Colors.yellow}
            }
            ListElement{
                name: "Orange"
                color: function(){return Colors.orange}
            }
            ListElement{
                name: "Red"
                color: function(){return Colors.red}
            }
            ListElement{
                name: "Magenta"
                color: function(){return Colors.magenta}
            }
            ListElement{
                name: "Purple"
                color: function(){return Colors.purple}
            }
            ListElement{
                name: "Blue"
                color: function(){return Colors.blue}
            }
            ListElement{
                name: "Teal"
                color: function(){return Colors.teal}
            }
            ListElement{
                name: "Green"
                color: function(){return Colors.green}
            }
        }
        ColumnLayout{
            id: layout_column
            width: parent.width
            spacing: 0
            Row{
                spacing: 20
                Label{
                    text: qsTr("Equivalents with the material")
                    font: Typography.subtitle
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: checbox_disabled
                    text: qsTr("Disabled")
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: checbox_dark
                    text: qsTr("Page dark mode")
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Row {
                spacing: 10
                Layout.topMargin: 10
                Layout.fillWidth: true
                Repeater{
                    model: accentColors
                    delegate: Rectangle{
                        required property var model
                        implicitWidth: 48
                        implicitHeight: 48
                        radius: 4
                        border.color: {
                            if(!enabled){
                                return layout_pane.FluentUI.theme.res.accentFillColorDisabled
                            }
                            return model.color().darkest()
                        }
                        border.width: 1
                        color: {
                            if(!enabled){
                                return layout_pane.FluentUI.theme.res.accentFillColorDisabled
                            }
                            return mouse_item_accent_color.containsMouse? model.color().lightest() : model.color().normal
                        }
                        Icon{
                            source: FluentIcons.graph_CheckMark
                            width: 24
                            height: 24
                            anchors.centerIn: parent
                            color: Colors.basedOnLuminance(parent.color)
                            visible: model.color() === layout_pane.FluentUI.primaryColor
                        }
                        MouseArea{
                            id: mouse_item_accent_color
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                layout_pane.FluentUI.primaryColor = model.color()
                            }
                        }
                    }
                }
            }
            ColumnLayout{
                Layout.fillWidth: true
                Layout.topMargin: 10
                spacing: 0
                enabled: !checbox_disabled.checked
                RowItem{
                    title: qsTr("Button")
                    leftItem: Button{
                        text: qsTr("Content")
                        icon.source:  "qrc:/qt/qml/Gallery/res/image/logo.png"
                        icon.color: "#00000000"
                    }
                    rightItem: M.Button{
                        text: qsTr("Content")
                        icon.source:  "qrc:/qt/qml/Gallery/res/image/logo.png"
                        icon.color: "#00000000"
                    }
                }
                RowItem{
                    title: qsTr("FilledButton")
                    leftItem: Button{
                        text: qsTr("Content")
                        highlighted: true
                    }
                    rightItem: M.Button{
                        text: qsTr("Content")
                        highlighted: true
                    }
                }
                RowItem{
                    title: qsTr("CheckBox")
                    leftItem: CheckBox{
                        text: qsTr("Content")
                        tristate: true
                        checked: true
                    }
                    rightItem: M.CheckBox{
                        text: qsTr("Content")
                        tristate: true
                        checked: true
                    }
                }
                RowItem{
                    title: qsTr("RadioButton")
                    leftItem: RadioButton{
                        text: qsTr("Content")
                        checkable: false
                        checked: true
                        onClicked: {
                            checked = !checked
                        }
                    }
                    rightItem: M.RadioButton{
                        text: qsTr("Content")
                        checkable: false
                        checked: true
                        onClicked: {
                            checked = !checked
                        }
                    }
                }
                RowItem{
                    title: qsTr("ComboBox")
                    leftItem: ComboBox{
                        model: [qsTr("First"), qsTr("Second"), qsTr("Third")]
                    }
                    rightItem: M.ComboBox{
                        model: [qsTr("First"), qsTr("Second"), qsTr("Third")]
                    }
                }
                RowItem{
                    title: qsTr("Switch")
                    leftItem: Switch{
                        text: qsTr("Content")
                        checked: true
                    }
                    rightItem: M.Switch{
                        text: qsTr("Content")
                        checked: true
                    }
                }
                RowItem{
                    title: qsTr("Slider")
                    leftItem: Slider{
                        value: 0.5
                    }
                    rightItem: M.Slider{
                        value: 0.5
                    }
                }
                RowItem{
                    title: qsTr("ProgressBar")
                    id: item_progressbar
                    property real value: 0
                    leftItem: ProgressBar{
                        value: item_progressbar.value
                    }
                    rightItem: M.ProgressBar{
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
                    Layout.bottomMargin: 30
                    title: qsTr("TextField")
                    leftItem: TextField{
                        placeholderText: qsTr("TextField")
                    }
                    rightItem: M.TextField{
                        placeholderText: qsTr("TextField")
                    }
                }
            }
        }
    }
}
