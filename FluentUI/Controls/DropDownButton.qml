import QtQuick
import QtQuick.Controls
import FluentUI.impl

StandardButton {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    default property alias contentData: menu.contentData
    property alias menu: menu
    icon.name: FluentIcons.graph_ChevronDown
    icon.width: 12
    icon.height: 12
    spacing: 6
    LayoutMirroring.enabled: true
    onClicked: {
        menu.popup(control,0,control.height)
    }
    Menu {
        id: menu
        dim: true
        modal: true
        width: parent.width
        FluentUI.minimumHeight: control.FluentUI.minimumHeight
        Overlay.modal: Item{}
        FluentUI.dark: control.FluentUI.dark
        FluentUI.primaryColor: control.FluentUI.primaryColor
    }
}
