import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.TreeViewDelegate {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: leftMargin + __contentIndent + implicitContentWidth + rightPadding + rightMargin
    implicitHeight: Math.max(indicator ? indicator.height : 0, implicitContentHeight) * 1.25
    indentation: indicator ? indicator.width : 12
    leftMargin: 4
    rightMargin: 4
    spacing: 4
    topPadding: contentItem ? (height - contentItem.implicitHeight) / 2 : 0
    leftPadding: !mirrored ? leftMargin + __contentIndent : width - leftMargin - __contentIndent - implicitContentWidth
    highlighted: control.selected || control.current
                 || ((control.treeView.selectionBehavior === TableView.SelectRows
                      || control.treeView.selectionBehavior === TableView.SelectionDisabled)
                     && control.row === control.treeView.currentRow)
    required property int row
    required property int column
    required property var model
    readonly property real __contentIndent: !isTreeNode ? 0 : (depth * indentation) + (indicator ? indicator.width + spacing : 0)
    property color rowSelectedBorderColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
    property color rowSelectedColor: Colors.withOpacity(rowSelectedBorderColor,0.1)
    indicator: Item {
        readonly property real __indicatorIndent: control.leftMargin + (control.depth * control.indentation)
        x: !control.mirrored ? __indicatorIndent : control.width - __indicatorIndent - width
        y: (control.height - height) / 2
        implicitWidth: 20
        implicitHeight: 36
        Icon {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: 12
            height: 12
            rotation:  control.expanded ? 90 : (control.mirrored ? 180 : 0)
            source: FluentIcons.graph_ChevronRight
        }
    }
    background: Rectangle {
        implicitHeight: 36
        color: control.highlighted
               ? control.rowSelectedColor
               : (control.treeView.alternatingRows && control.row % 2 === 0
                  ? control.FluentUI.theme.res.subtleFillColorTertiary : control.FluentUI.theme.res.subtleFillColorTransparent)
        Item{
            anchors.fill: parent
            visible: control.highlighted
            Rectangle{
                width: 1
                height: parent.height
                anchors.left: parent.left
                color: control.rowSelectedBorderColor
                visible: control.column === 0
            }
            Rectangle{
                width: 1
                height: parent.height
                anchors.right: parent.right
                color: control.rowSelectedBorderColor
                visible: control.column === control.treeView.columns - 1
            }
            Rectangle{
                width: parent.width
                height: 1
                anchors.top: parent.top
                color: control.rowSelectedBorderColor
            }
            Rectangle{
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: control.rowSelectedBorderColor
            }
        }
    }
    contentItem: Label {
        clip: false
        text: control.model.display
        elide: Text.ElideRight
        visible: !control.editing
    }
    TableView.editDelegate: FocusScope {
        width: parent.width
        height: parent.height
        readonly property int __role: {
            let model = control.treeView.model
            let index = control.treeView.index(row, column)
            let editText = model.data(index, Qt.EditRole)
            return editText !== undefined ? Qt.EditRole : Qt.DisplayRole
        }
        TextField {
            id: textField
            x: control.contentItem.x
            y: (parent.height - height) / 2
            width: control.contentItem.width
            text: control.treeView.model.data(control.treeView.index(row, column), __role)
            focus: true
        }
        TableView.onCommit: {
            let index = TableView.view.index(row, column)
            TableView.view.model.setData(index, textField.text, __role)
        }
        Component.onCompleted: textField.selectAll()
    }
}
