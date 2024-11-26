import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Breadcrumb")
    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls

ColumnLayout{
    width: parent.width
    spacing: 10
    Component.onCompleted: {
        var items = []
        for(var i=0;i<10;i++){
            items.push({title:"Item_"+(i+1)})
        }
        breadcrumb_1.items = items
        breadcrumb_2.items = items
    }
    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 68
        padding: 10
        Breadcrumb{
            id: breadcrumb_1
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Frame{
        Layout.fillWidth: true
        Layout.preferredHeight: 120
        padding: 10
        Layout.topMargin: 20
        ColumnLayout{
            anchors.verticalCenter: parent.verticalCenter
            width:parent.width
            spacing: 10
            FilledButton{
                text: qsTr("Reset sample")
                onClicked:{
                    var items = []
                    for(var i=0;i<10;i++){
                        items.push({title:"Item_"+(i+1)})
                    }
                    breadcrumb_2.items = items
                }
            }
            Breadcrumb{
                id:breadcrumb_2
                spacing: 8
                moreSize: 32
                font: Typography.subtitle
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                onClickItem:
                    (model)=>{
                        if(model.index+1!==count()){
                            breadcrumb_2.remove(model.index+1,count()-model.index-1)
                        }
                    }
            }
        }
    }
}
`}


}
