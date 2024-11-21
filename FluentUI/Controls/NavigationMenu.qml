import QtQuick
import QtQuick.Controls

Menu{
    property var modelData
    property var view
    id: control
    modal: true
    title: {
        if(modelData){
            return modelData.title
        }
        return ""
    }
    enabled: {
        if(modelData){
            return modelData.enabled
        }
        return true
    }
    Instantiator{
        model: {
            if(modelData){
                return modelData.children
            }
            return []
        }
        delegate: QtObject{
            property var modelData : model.modelData
            property var parent: control
            property bool isExpander: modelData instanceof PaneItemExpander
            property var value
        }
        onObjectAdded:
            (index, object) => {
                if(object.isExpander){
                    var component = Qt.createComponent("NavigationMenu.qml");
                    if (component.status === Component.Ready) {
                        var menu = component.createObject(object.parent.contentItem,{modelData:object.modelData,view:control.view})
                        object.value = menu
                        control.insertMenu(index,menu)
                    }
                }else{
                    component = Qt.createComponent("NavigationMenuItem.qml");
                    if (component.status === Component.Ready) {
                        var item = component.createObject(object.parent.contentItem,{modelData:object.modelData,view:control.view})
                        object.value = item
                        control.insertItem(index,item)
                    }
                }
            }
        onObjectRemoved:
            (index, object) => {
                if(object.isExpander){
                    control.removeMenu(object.value)
                }else{
                    control.removeItem(object.value)
                }
            }
    }
    delegate: MenuItem{
        property var modelData: subMenu.modelData
        InfoBadge{
            dot: true
            anchors{
                right: parent.right
                top: parent.top
                rightMargin: 8
                topMargin: 8
            }
            visible: {
                if(modelData instanceof PaneItem){
                    if(modelData.count !== 0){
                        return true
                    }
                    return false
                }else{
                    for(var i=0;i<modelData.children.length;i++){
                        var item = modelData.children[i]
                        if((item instanceof PaneItem || item instanceof PaneItemExpander) && item.count !==0){
                            return true
                        }
                    }
                    return false
                }
            }
        }
    }
    Overlay.modal: Item {}
}
