import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property alias textArea: text_area
    property alias text : text_area.text
    property bool showLineNumbers: true
    property int currentLineNumber: -1
    property int rowHeight: Math.ceil(fontMetrics.lineSpacing)
    property Component highlighter: comp_highlighter
    onWidthChanged: text_area.update()
    onHeightChanged: text_area.update()
    property font font: Typography.body
    LineNumberModel {
        id: line_number_model
        lineCount: text_area.text !== "" ? text_area.lineCount : 0
    }
    Component{
        id: comp_highlighter
        QMLHighlighter{ }
    }
    AutoLoader{
        id: loader_highlighter
        sourceComponent: control.highlighter
        onLoaded: {
          loader_highlighter.item.textDocument = text_area.textDocument
        }
    }
    Flickable {
        id: flickable_editor
        anchors.fill: parent
        ScrollBar.horizontal: scrollbar_h
        ScrollBar.vertical: scrollbar_v
        boundsBehavior: Flickable.StopAtBounds
        TextArea.flickable: MultiLineTextBox {
            id: text_area
            topPadding: 10
            font: control.font
            leftPadding: showLineNumbers ? Math.max(60,flickable_line.width+20) : 20
            tabStopDistance: fontMetrics.averageCharacterWidth * 3
            onCursorPositionChanged: {
                control.currentLineNumber = line_number_model.currentLineNumber(text_area.textDocument, text_area.cursorPosition)
            }
        }
        FontMetrics {
            id: fontMetrics
            font: text_area.font
        }
        clip: true
        Rectangle{
            width: Math.max(flickable_editor.contentWidth,flickable_editor.width)
            height: control.rowHeight
            y: control.currentLineNumber * control.rowHeight + 10
            color: {
                if(control.currentLineNumber<0){
                    return Colors.transparent
                }
                return control.FluentUI.theme.res.solidBackgroundFillColorSecondary
            }
        }
    }
    Flickable {
        id: flickable_line
        width: fontMetrics.averageCharacterWidth * (Math.floor(Math.log10(text_area.lineCount)) + 1) + 20
        anchors{
            left: parent.left
            leftMargin: 20
            top: flickable_editor.top
            topMargin: 10
            bottom: flickable_editor.bottom
        }
        clip: true
        interactive: false
        contentY: flickable_editor.contentY
        visible: control.showLineNumbers
        Column {
            anchors.fill: parent
            Repeater {
                id: repeatedflickable_line
                model: LineNumberModel {
                    lineCount:  text_area.lineCount
                }
                delegate: Item {
                    required property int index
                    width: parent.width
                    height: control.rowHeight
                    Label {
                        id: numbers
                        text: parent.index + 1
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        color: (control.currentLineNumber === parent.index) ? control.accentColor.defaultBrushFor(control.FluentUI.dark) : control.FluentUI.theme.res.textFillColorTertiary
                        font: text_area.font
                    }
                }
            }
        }
    }
    ScrollBar {
        id: scrollbar_v
        anchors{
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: 2
        }
    }
    ScrollBar {
        id: scrollbar_h
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 2
        }
    }
}
