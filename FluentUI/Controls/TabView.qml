import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Item {
    FluentUI.theme: Theme.of(control)
    property int tabWidthBehavior : TabViewType.Equal
    property int closeButtonVisibility : TabViewType.Always
    property int itemWidth: 146
    property bool addButtonVisibility: true
    signal newPressed
    id:control
    implicitHeight: height
    implicitWidth: width
    anchors.fill: {
        if(parent)
            return parent
        return undefined
    }
    QtObject {
        id: d
        property int dragIndex: -1
        property bool dragBehavior: false
        property bool itemPress: false
        property int maxEqualWidth: 240
    }
    MouseArea{
        anchors.fill: parent
        preventStealing: true
    }
    ListModel{
        id:tab_model
    }
    IconButton{
        id:btn_new
        visible: addButtonVisibility
        width: 34
        height: 34
        x:Math.min(tab_nav.contentWidth,tab_nav.width)
        anchors.top: parent.top
        icon.name:  FluentIcons.graph_Add
        icon.width: 14
        icon.height: 14
        onClicked: {
            newPressed()
        }
    }
    ListView{
        id:tab_nav
        height: 34
        orientation: ListView.Horizontal
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            rightMargin: 34
        }
        interactive: false
        model: tab_model
        move: Transition {
            NumberAnimation { properties: "x"; duration: 100; easing.type: Easing.OutCubic }
            NumberAnimation { properties: "y"; duration: 100; easing.type: Easing.OutCubic }
        }
        moveDisplaced: Transition {
            NumberAnimation { properties: "x"; duration: 300; easing.type: Easing.OutCubic}
            NumberAnimation { properties: "y"; duration: 100;  easing.type: Easing.OutCubic }
        }
        clip: true
        ScrollBar.horizontal: ScrollBar{
            id: scroll_nav
            policy: ScrollBar.AlwaysOff
        }
        delegate:  Item{
            width: item_container.width
            height: item_container.height

            DropArea{
                anchors.fill: parent
                onEntered:
                    (drag)=>{
                        tab_model.move(drag.source.visualIndex, item_container.visualIndex,1)
                    }
            }
            Control{
                id:item_container
                property int visualIndex: model.index
                readonly property bool isCurrent: model.index === tab_nav.currentIndex
                readonly property bool isNext: model.index-1 === tab_nav.currentIndex
                readonly property bool isPrevious: model.index+1 === tab_nav.currentIndex
                height: tab_nav.height
                Drag.active: mouse_tab_item.drag.active
                Drag.source: item_container
                Drag.hotSpot.x: width/2
                width: {
                    if(tabWidthBehavior === TabViewType.Equal){
                        return Math.max(Math.min(d.maxEqualWidth,tab_nav.width/tab_nav.count),41 + item_btn_close.width)
                    }
                    if(tabWidthBehavior === TabViewType.SizeToContent){
                        return itemWidth
                    }
                    if(tabWidthBehavior === TabViewType.Compact){
                        return hover_handler.hovered || item_btn_close.hovered || tab_nav.currentIndex === index  ? itemWidth : 41 + item_btn_close.width
                    }
                    return Math.max(Math.min(d.maxEqualWidth,tab_nav.width/tab_nav.count),41 + item_btn_close.width)
                }
                states: [
                    State {
                        when: mouse_tab_item.drag.active
                        ParentChange {
                            target: item_container
                            parent: tab_nav
                        }
                        AnchorChanges {
                            target: item_container
                            anchors {
                                horizontalCenter: undefined
                                verticalCenter: undefined
                            }
                        }
                    }
                ]
                MouseArea {
                    id: mouse_tab_item
                    anchors.fill: parent
                    drag.target: item_container
                    drag.axis: Drag.XAxis
                    onClicked: {
                        tab_nav.currentIndex = model.index
                    }
                }
                Rectangle{
                    anchors.fill: parent
                    radius: 6
                    color: Theme.uncheckedInputColor(item_container,true,true,control.FluentUI.dark)
                }
                TabBackgroundImpl{
                    width: item_container.width + 6*2
                    height: item_container.height
                    x: -6
                    visible: item_container.isCurrent
                    radius: 6
                    color: control.FluentUI.theme.res.solidBackgroundFillColorQuarternary
                    strokeColor: control.FluentUI.theme.res.dividerStrokeColorDefault
                }
                RowLayout{
                    spacing: 0
                    height: parent.height
                    Image{
                        source: model.icon
                        Layout.leftMargin: 10
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Label{
                        id:item_text
                        text: model.text
                        Layout.leftMargin: 10
                        visible: {
                            if(tabWidthBehavior === TabViewType.Equal){
                                return true
                            }
                            if(tabWidthBehavior === TabViewType.SizeToContent){
                                return true
                            }
                            if(tabWidthBehavior === TabViewType.Compact){
                                return hover_handler.hovered || item_btn_close.hovered || tab_nav.currentIndex === index
                            }
                            return false
                        }
                        Layout.preferredWidth: visible?item_container.width - 41 - item_btn_close.width:0
                        elide: Text.ElideRight
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
                IconButton{
                    id:item_btn_close
                    icon.name: FluentIcons.graph_ChromeClose
                    icon.width: 10
                    icon.height: 10
                    width: visible ? 24 : 0
                    height: 24
                    visible: {
                        if(closeButtonVisibility === TabViewType.Never)
                            return false
                        if(closeButtonVisibility === TabViewType.OnHover)
                            return hover_handler.hovered || item_btn_close.hovered
                        return true
                    }
                    anchors{
                        right: parent.right
                        rightMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                    onClicked: {
                        tab_model.remove(index)
                    }
                }
                Rectangle{
                    width: 1
                    height: 16
                    anchors{
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }
                    visible: !item_container.isCurrent && !item_container.isPrevious
                    color: control.FluentUI.theme.res.dividerStrokeColorDefault
                }
                HoverHandler{
                    id: hover_handler
                }
            }
        }
        WheelHandler{
            onWheel:
                (wheel)=>{
                    if (wheel.angleDelta.y > 0) scroll_nav.decrease()
                    else scroll_nav.increase()
                }
        }
    }
    Item{
        id:container
        anchors{
            top: tab_nav.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        Repeater{
            model:tab_model
            AutoLoader{
                property var argument: model.argument
                anchors.fill: parent
                sourceComponent: model.page
                visible: tab_nav.currentIndex === index
            }
        }
    }
    function createTab(icon,text,page,argument={}){
        return {icon:icon,text:text,page:page,argument:argument}
    }
    function appendTab(icon,text,page,argument){
        tab_model.append(createTab(icon,text,page,argument))
    }
    function setTabList(list){
        tab_model.clear()
        tab_model.append(list)
    }
    function count(){
        return tab_nav.count
    }
}
