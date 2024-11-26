import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Tour")

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls

ColumnLayout {
    width: parent.width
    Tour{
        id:tour
        Component.onCompleted:{
            steps.push({title:qsTr("Upload File"),description: qsTr("Put your files here."),target:()=>btn_upload})
            steps.push({title:qsTr("Save"),description: qsTr("Save your changes."),target:()=>btn_save})
            steps.push({title:qsTr("Other Actions"),description: qsTr("Click to see other actions."),target:()=>btn_more,isLast:true})
        }
    }
    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 130
        padding: 10
        FilledButton{
            anchors{
                top: parent.top
                topMargin: 14
            }
            text: qsTr("Begin Tour")
            onClicked: {
                tour.open()
            }
        }
        Row{
            spacing: 20
            anchors{
                top: parent.top
                topMargin: 60
            }
            Button{
                id: btn_upload
                text: qsTr("Upload")
                onClicked: {
                }
            }
            FilledButton{
                id: btn_save
                text: qsTr("Save")
                onClicked: {
                }
            }
            IconButton{
                id: btn_more
                icon.name: FluentIcons.graph_More
                icon.width: 15
                icon.height: 15
                onClicked: {
                }
            }
        }
    }
}
`}

}
