import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("SpinBox")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet: 'import QtQuick
import QtQuick.Controls
import FluentUI.Controls

Column{
    spacing: 10
    SpinBox {

    }
    SpinBox {
        editable: true
    }
    SpinBox {
        id: spinBox
        from: 0
        to: items.length - 1
        value: 1
        property var items: ["Small", "Medium", "Large"]
        validator: RegularExpressionValidator {
            regularExpression: new RegExp("(Small|Medium|Large)", "i")
        }
        textFromValue: function(value) {
            return items[value];
        }
        valueFromText: function(text) {
            for (var i = 0; i < items.length; ++i) {
                if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                    return i
            }
            return spinBox.value
        }
    }
}
'}

}
