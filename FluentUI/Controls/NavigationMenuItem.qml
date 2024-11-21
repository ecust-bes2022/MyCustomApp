import QtQuick
import QtQuick.Controls
import FluentUI.impl

MenuItem{
    property var modelData
    property var view
    enabled: modelData.enabled
    text: modelData.title
    onClicked: {
        modelData.tap()
        view.tap(modelData)
    }
    rightPadding: modelData.count === 0 ? 10 : 30
    AutoLoader{
        property var model: modelData
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        sourceComponent: {
            if(modelData instanceof PaneItem){
                if(modelData.count === 0){
                    return undefined
                }
                if(modelData.infoBadge){
                    return modelData.infoBadge
                }
                return comp_info_badge
            }else{
                return undefined
            }
        }
    }
}
