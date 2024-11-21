import QtQuick
import QtQuick.Controls
import FluentUI.impl

TextBox{
    id: control
    property var items:[]
    property string noResultsMessage: qsTr("No results found")
    property string textRole: "title"
    property int maximumCount: 8
    property var filter: function(item){
        if(item.title){
            if(item.title.indexOf(control.text)!==-1){
                return true
            }
        }
        return false
    }
    signal tap(var data)
    QtObject{
        id: d
        property var sourceItems: []
        property bool silentFlag: false
        signal upPressed
        signal downPressed
        signal enterPressed
    }
    onTextChanged: {
        if(!d.silentFlag){
            var result = []
            items.forEach(function(item){
                if(control.filter(item)){
                    result.push(item)
                }
            })
            if(result.length===0){
                result.push({__type:-999})
            }
            d.sourceItems = result
            popup.popup(control)
        }
    }
    Keys.onUpPressed: {
        d.upPressed()
    }
    Keys.onDownPressed: {
        d.downPressed()
    }
    Keys.onEnterPressed: {
        d.enterPressed()
    }
    Keys.onReturnPressed: {
        d.enterPressed()
    }
    DropDownPopup{
        id: popup
        width: control.width
        modal: false
        dim: false
        FluentUI.dark: control.FluentUI.dark
        FluentUI.primaryColor: control.FluentUI.primaryColor
        height: 40 * Math.min(d.sourceItems.length,maximumCount)+4
        content: Item{
            Connections{
                target: d
                function onUpPressed(){
                    list_view.currentIndex = Math.max(list_view.currentIndex-1,0)
                }
                function onDownPressed(){
                    list_view.currentIndex = Math.min(list_view.currentIndex+1,list_view.count-1)
                }
                function onEnterPressed(){
                    var modelData =  d.sourceItems[list_view.currentIndex]
                    control.tap(modelData)
                    popup.close()
                }
            }
            ListView{
                id: list_view
                clip: true
                anchors.fill: parent
                topMargin: 2
                bottomMargin: 2
                model: d.sourceItems
                ScrollBar.vertical: ScrollBar{}
                boundsBehavior: ListView.StopAtBounds
                delegate: Item{
                    id: item_root
                    property bool isEmpty: modelData.__type === -999
                    enabled: !(modelData.enabled === false)
                    implicitHeight: 40
                    implicitWidth: control.width
                    ListTile{
                        anchors{
                            fill: parent
                            leftMargin: 4
                            rightMargin: 4
                            topMargin: 2
                            bottomMargin: 2
                        }
                        highlighted: !item_root.isEmpty && list_view.currentIndex === index
                        enabled: !isEmpty
                        text: {
                            if(isEmpty){
                                return control.noResultsMessage
                            }
                            return modelData["title"]
                        }
                        onClicked: {
                            control.tap(modelData)
                            popup.close()
                            updateText(text)
                        }
                    }
                }
            }
        }
    }
    function close(){
        popup.close()
    }
    function updateText(text){
        d.silentFlag = true
        control.text = text
        d.silentFlag = false
    }
}
