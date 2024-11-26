import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery
import FluentUI.impl

ContentPage {

    id: control
    title: qsTr("TreeDataGrid")
    property int depthPadding: 15
    TreeDataGridController{
        id: controller
        onLoadDataStart: {
            panel_loading.visible = true
        }
        onLoadDataSuccess: {
            dataModel.sourceData  = controller.data
            panel_loading.visible = false
        }
    }
    Component{
        id: comp_row_avatar
        Item{
            RoundImageView{
                width: Math.min(parent.width,parent.height) - 16
                height: width
                radius: width/2
                borderWidth: 2
                sourceSize: Qt.size(width*2,height*2)
                source: rowModel.avatar
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                }
            }
        }
    }
    Component{
        id: comp_row_key
        Item{
            AutoLoader{
                property var treeNode: rowModel.treeNode
                anchors.fill: parent
                sourceComponent: RowLayout{
                    anchors.fill: parent
                    spacing: 0
                    Item{
                        Layout.fillHeight: true
                        implicitWidth: 6 + rowModel.depth * control.depthPadding
                    }
                    IconButton{
                        Layout.alignment: Qt.AlignVCenter
                        opacity: rowModel.hasChildren
                        enabled: opacity
                        icon.name: FluentIcons.graph_ChevronDown
                        icon.width: 16
                        icon.height: 16
                        padding: 0
                        contentItem.rotation: rowModel.expanded ? 0 : -90
                        onClicked: {
                            if(rowModel.expanded){
                                dataModel.collapse(rowModel.index)
                            }else{
                                dataModel.expand(rowModel.index)
                            }
                        }
                    }
                    Label{
                        Layout.alignment: Qt.AlignVCenter
                        text: String(display)
                        elide: Label.ElideRight
                        Layout.fillWidth: true
                        Layout.leftMargin: 6
                    }
                }
            }
            clip: true
        }
    }
    Component{
        id: comp_column_frozen
        Item{
            Label{
                anchors.fill: parent
                text: columnModel.title
                verticalAlignment: Qt.AlignVCenter
                leftPadding: 10
                rightPadding: 10
                elide: Label.ElideRight
            }
            IconButton{
                id: btn_pinned
                icon.name: FluentIcons.graph_Pinned
                icon.width: 12
                icon.height: 12
                width: 24
                height: 24
                icon.color: columnModel.frozen ? Theme.accentColor.defaultBrushFor()  : btn_pinned.FluentUI.textColor
                anchors.right: parent.right
                onClicked: {
                    columnModel.frozen = !columnModel.frozen
                }
            }
        }
    }
    Component{
        id: comp_column_close
        Item{
            Label{
                anchors.fill: parent
                text: columnModel.title
                verticalAlignment: Qt.AlignVCenter
                leftPadding: 10
                rightPadding: 10
                elide: Label.ElideRight
            }
            IconButton{
                id: btn_close
                icon.name: FluentIcons.graph_ChromeClose
                icon.width: 10
                icon.height: 10
                width: 28
                height: 28
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                onClicked: {
                    dataGrid.columnSourceModel.remove(columnModel.index)
                }
            }
        }
    }
    Component{
        id: comp_edit_combobox
        ComboBox{
            model: ["20", "30", "40", "60"]
            editable: true
            Component.onCompleted: {
                editText = display
                this.contentItem.forceActiveFocus()
                this.contentItem.selectAll()
            }
            onActiveFocusChanged: {
                if(!activeFocus){
                    dataGrid.closeEditor()
                }
            }
            Keys.onEnterPressed: {
                changeDisplay()
            }
            Keys.onReturnPressed: {
                changeDisplay()
            }
            function changeDisplay(){
                rowModel[columnModel.dataIndex] = editText
                dataGrid.closeEditor()
            }
        }
    }
    TreeDataGridModel{
        id: dataModel
    }
    TreeDataGrid{
        id: dataGrid
        anchors{
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            bottomMargin: 10
        }
        sourceModel: dataModel
        columnSourceModel: ListModel{
            ListElement{
                title: qsTr("Key")
                dataIndex: "key"
                width: 240
                frozen: true
                rowDelegate: function(){return comp_row_key}
            }
            ListElement{
                title: qsTr("Name")
                dataIndex: "name"
                width: 100
                frozen: true
                delegate: function(){return comp_column_frozen}
            }
            ListElement{
                title: qsTr("Avatar")
                dataIndex: "avatar"
                width: 100
                frozen: false
                rowDelegate: function(){return comp_row_avatar}
                delegate: function(){return comp_column_frozen}
            }
            ListElement{
                title: qsTr("Age")
                dataIndex: "age"
                editDelete: function(){return comp_edit_combobox}
                width: 100
            }
            ListElement{
                title: qsTr("Address")
                dataIndex: "address"
                width: 200
                delegate: function(){return comp_column_close}
            }
            ListElement{
                title: qsTr("Description")
                dataIndex: "description"
                width: 200
                delegate: function(){return comp_column_close}
            }
        }
    }
    Component.onCompleted: {
        controller.loadData()
    }
    Pane{
        id: panel_loading
        anchors.fill: dataGrid
        ProgressRing{
            anchors.centerIn: parent
            indeterminate: true
        }
        background: Rectangle{
            color: Theme.res.solidBackgroundFillColorBase
        }
    }
}
