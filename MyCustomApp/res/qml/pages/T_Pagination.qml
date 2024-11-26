import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage{

    title: qsTr("Pagination")


    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import FluentUI.Controls

Item{
    height: 180
    Column{
        spacing: 20
        Pagination{
            pageCurrent: 1
            pageButtonCount: 5
            itemCount: 5000
        }
        Pagination{
            pageCurrent: 2
            itemCount: 5000
            pageButtonCount: 7
        }
        Pagination{
            pageCurrent: 3
            itemCount: 5000
            pageButtonCount: 9
        }
    }
}
`}



}
