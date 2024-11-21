import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item{
    id:control
    FluentUI.theme: Theme.of(control)
    property Component separator: comp_separator
    property var items: []
    property int spacing: 10
    property int moreSpacing: 0
    property font font: Typography.body
    property int moreSize: 24
    property string textRole: "title"
    signal clickItem(var model)
    height: 30
    onItemsChanged: {
        d.cacheItems = []
        list_model.clear()
        list_model.append(items)
    }
    Component{
        id: comp_separator
        Icon{
            source: FluentIcons.graph_ChevronRightMed
            implicitHeight: 14
            implicitWidth: 14
            color: control.FluentUI.theme.res.textFillColorTertiary
        }
    }
    ListModel{
        id:list_model
    }
    QtObject{
        id: d
        property var cacheItems: []
        onCacheItemsChanged: {
            list_view.leftMargin = -cacheItems.reduce((sum, item) => sum + item.width, 0)
        }
    }
    RowLayout {
        anchors.fill: parent
        spacing: 0
        IconButton{
            id: btn_more
            icon.name: FluentIcons.graph_More
            icon.width: control.moreSize
            icon.height: control.moreSize
            Layout.preferredWidth: visible ? control.moreSize : 0
            Layout.fillHeight: true
            visible: d.cacheItems.length !== 0
            background: Item{}
            onClicked: {
                loader_menu.sourceComponent = comp_menu
            }
            FluentUI.textColor: {
                if(btn_more.hovered){
                    return control.FluentUI.theme.res.textFillColorPrimary
                }
                return control.FluentUI.theme.res.textFillColorTertiary
            }
        }
        Item{
            implicitWidth: visible ? control.moreSpacing : 0
            Layout.fillHeight: true
            visible: btn_more.visible
        }
        ListView{
            id:list_view
            Layout.fillWidth: true
            Layout.fillHeight: true
            orientation: ListView.Horizontal
            model: list_model
            clip: true
            spacing: 0
            interactive: false
            boundsBehavior: ListView.StopAtBounds
            cacheBuffer: 65535
            delegate: Item{
                height: item_layout.height
                width: item_layout.width
                property var dataModel: model
                property var index: model.index
                property bool hide: x-list_view.contentWidth+list_view.width < 0
                property bool isLast: index === list_view.count-1
                property color textColor: {
                    if(item_mouse.containsMouse){
                        return control.FluentUI.theme.res.textFillColorPrimary
                    }
                    return isLast ? control.FluentUI.theme.res.textFillColorPrimary : control.FluentUI.theme.res.textFillColorTertiary
                }
                visible: !hide
                clip: true
                onHideChanged: {
                    if(hide){
                        d.cacheItems.push(this)
                    }else{
                        var pos = d.cacheItems.indexOf(this)
                        if (pos > -1) {
                            d.cacheItems.splice(pos, 1)
                        }
                    }
                    d.cacheItems = d.cacheItems.sort(function(a, b){return a.index - b.index})
                }
                RowLayout{
                    id:item_layout
                    height: list_view.height
                    spacing: control.spacing
                    AutoLoader{
                        sourceComponent: control.separator
                        Layout.leftMargin: control.spacing
                        Layout.alignment: Qt.AlignVCenter
                        visible: 0 !== index
                    }
                    Label{
                        text: model[control.textRole]
                        font: control.font
                        Layout.alignment: Qt.AlignVCenter
                        color: textColor
                        MouseArea{
                            id:item_mouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                control.clickItem(model)
                            }
                        }
                    }
                }
            }
        }
    }
    AutoLoader{
        id: loader_menu
    }
    Component{
        id: comp_menu
        Menu{
            id: menu
            Component.onCompleted: {
                menu.popup()
            }
            onClosed:{
                loader_menu.sourceComponent = undefined
            }
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            Repeater{
                model: d.cacheItems
                delegate: MenuItem{
                    text: {
                        if(modelData.dataModel){
                            return modelData.dataModel.title
                        }
                        return ""
                    }
                    onClicked: {
                        menu.close()
                        control.clickItem(modelData.dataModel)
                    }
                }
            }
        }
    }
    function remove(index,count){
        for(var i=index;i<count+index;i++){
            var pos = d.cacheItems.indexOf(list_view.itemAtIndex(i))
            if (pos > -1) {
                d.cacheItems.splice(pos, 1)
            }
        }
        d.cacheItems.sort(function(a, b){return a.index - b.index})
        list_model.remove(index,count)
    }
    function count(){
        return list_model.count
    }
}
