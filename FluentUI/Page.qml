import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.Page {
    id: control
    spacing: 0
    FluentUI.radius: 7
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    background: Item{}
    header: Label{
        text: control.title
        font: Typography.title
        visible: text !== ""
        topPadding: 24
        leftPadding: 24
        rightPadding: 24
    }
    padding: 24
}
