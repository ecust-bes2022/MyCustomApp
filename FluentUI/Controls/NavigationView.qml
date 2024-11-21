import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

Rectangle {
    id: control
    FluentUI.theme: Theme.of(control)
    property int displayMode: NavigationViewType.Auto
    property int sideBarWidth: 320
    property int appBarHeight: 48
    property int titleBarTopMargin: 0
    property int sideItemHeight: 40
    property int topBarHeight: 50
    property string title
    property var logo
    property list<QtObject> items
    property list<QtObject> footerItems
    property Component logoDelegate: comp_logo
    property Item autoSuggestBox
    property Component autoSuggestBoxReplacement: comp_search_icon
    property Component leading
    property Component trailing
    property bool sideBarShadow: true
    property PageRouter router
    property alias goBackButton: button_back
    readonly property var sideBarView: d.isTop ? listview_navi_top : listview_navi
    readonly property var sideBarFooterView: d.isTop ? listview_navi_top_footer : listview_navi_footer
    signal tap(var item)
    signal rightTap(var item)
    signal sourceItemsChanged(var sourceItems)
    color: Colors.transparent
    Component.onCompleted: {
        d.displayMode = Qt.binding(function(){
            if(displayMode !== NavigationViewType.Auto){
                return displayMode
            }
            if(width <= 640){
                return NavigationViewType.Minimal
            }else if(width >= 1008){
                return NavigationViewType.Open
            }else{
                return NavigationViewType.Compact
            }
        })
        d.items = Qt.binding(function(){
            const stack = []
            for(var i=0;i<items.length;i++){
                stack.push(items[i])
            }
            stack.reverse()
            const result = []
            var index = 0
            while (stack.length > 0) {
                const current = stack.pop()
                current.__index = index
                // current.parent = control
                result.push(current)
                index++
                if (current instanceof PaneItemExpander) {
                    var children = []
                    for(var j=0;j<current.children.length;j++){
                        current.children[j].__parent = current
                        children.push(current.children[j])
                    }
                    children.reverse()
                    for(var k=0;k<children.length;k++){
                        stack.push(children[k])
                    }
                }
            }
            for(i=0;i<footerItems.length;i++){
                const footerItem = footerItems[i]
                footerItem.__footer = true
                footerItem.__index = index
                // footerItem.parent = control
                result.push(footerItem)
                index++
            }
            return result
        })
        d.topItems = Qt.binding(function(){
            const result = []
            for(var i=0;i<items.length;i++){
                var item = items[i]
                item.parent = control
                result.push(item)
            }
            for(i=0;i<footerItems.length;i++){
                var footerItem = footerItems[i]
                footerItem.parent = control
                result.push(footerItem)
            }
            return result
        })
    }
    Component{
        id: comp_logo
        Image{
            width: control.logo ? 18 : 0
            height: width
            source: control.logo ? control.logo : ""
        }
    }
    Component{
        id: comp_search_icon
        Icon{
            source: FluentIcons.graph_Search
            width: 18
            height: 18
        }
    }
    Item{
        id: d
        visible: false
        property int lastIndex : 0
        property bool showSideBarBorder: d.sideMenuEnabled && d.sideMenuVisible && !d.isTop
        property var items
        property var topItems
        property var topCacheItems: []
        property int displayMode: control.displayMode
        property bool sideMenuEnabled: d.displayMode === NavigationViewType.Minimal ||  d.displayMode === NavigationViewType.Compact
        property bool sideMenuVisible: false
        property bool isCompact: d.displayMode === NavigationViewType.Compact
        property bool isMinimal: d.displayMode === NavigationViewType.Minimal
        property bool isTop: d.displayMode === NavigationViewType.Top
        property var menuDatas: []
        function setHitTestVisible(id){
            if(Window.window instanceof FramelessWindow){
                Window.window.setHitTestVisible(id)
            }
        }
        function showPaneItems(modelData,target,x=0,y=0){
            const datas = []
            for(var i=0;i<modelData.children.length;i++){
                datas.push(modelData.children[i])
            }
            d.menuDatas = datas
            menu_pane_items.popup(target,x,y)
        }
        onDisplayModeChanged: {
            sideMenuVisible = false
        }
        onItemsChanged: {
            control.sourceItemsChanged(d.items)
        }
    }
    Item{
        id: layout_topbar
        width: parent.width
        anchors.top: layout_appbar.bottom
        height: d.isTop ? control.topBarHeight : 0
        visible: Number(height) !== 0
        clip: true
        Behavior on height{
            NumberAnimation{
                duration: Theme.fastAnimationDuration
                easing.type: Theme.animationCurve
            }
        }
        Component{
            id: comp_navi_top_header
            Item{
                implicitWidth: text_title.width + 10
                Label{
                    id: text_title
                    text: modelData.title
                    font: Typography.bodyStrong
                    anchors{
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
        Component{
            id: comp_navi_top_separator
            Rectangle{
                implicitWidth: 1
                color: control.FluentUI.theme.res.dividerStrokeColorDefault
            }
        }
        Component{
            id: comp_navi_top_item
            Item{
                enabled: modelData.enabled
                id: item_layout_top
                property bool isCurrentIndex: {
                    if(modelData.__footer){
                        return listview_navi_top_footer.currentIndex === index
                    }else{
                        return listview_navi_top.currentIndex === index
                    }
                }
                property bool isHighlight: {
                    if(modelData.__footer){
                        return isCurrentIndex
                    }
                    if(index === listview_navi_top.currentIndex){
                        return true
                    }
                    return false
                }
                height: control.topBarHeight
                width: (currentListView === listview_navi_top && modelData.__footer) ? 0 : item_icon_button.width + 10
                Component{
                    id: comp_leading
                    Icon{
                        source: modelData.iconSource
                        width: 18
                        height: 18
                    }
                }
                IconButton{
                    id: item_icon_button
                    text: modelData.title
                    anchors.centerIn: parent
                    horizontalPadding: 12
                    height: 40
                    spacing: 6
                    icon: modelData.icon
                    display: modelData.__footer ? Button.IconOnly : Button.TextBesideIcon
                    onClicked: {
                        if(modelData.__footer){
                            listview_navi_top.currentIndex = d.topItems.length - footerItems.length + index
                        }else{
                            listview_navi_top.currentIndex = index
                        }
                        modelData.tap()
                        control.tap(modelData)
                        if(modelData instanceof PaneItemExpander){
                            modelData.__expanded = !modelData.__expanded
                            d.showPaneItems(modelData,item_layout_top,0,item_layout_top.height)
                        }else{
                            d.sideMenuVisible = false
                        }
                    }
                    TapHandler{
                        acceptedButtons: Qt.RightButton
                        onTapped: {
                            modelData.rightTap()
                            control.rightTap(modelData)
                        }
                    }
                }
                AutoLoader{
                    property var model: modelData
                    anchors{
                        top: parent.top
                        topMargin: 8
                        right: parent.right
                    }
                    sourceComponent: {
                        if(modelData instanceof PaneItem){
                            if(!d.isTop){
                                return undefined
                            }
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
                InfoBadge{
                    dot: true
                    anchors{
                        right: parent.right
                        top: parent.top
                        rightMargin: 8
                        topMargin: 12
                    }
                    visible: {
                        if(modelData instanceof PaneItem){
                            if(modelData.count !== 0 && d.isTop){
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
                HighlightRectangle{
                    target: listview_navi_top
                    highlight: isHighlight
                    orientation: Qt.Horizontal
                    highlightSize: 18
                    bottomMargin: 6
                }
            }
        }
        RowLayout{
            id: layout_top_row
            anchors.fill: parent
            Item{
                id: layout_navi_top
                Layout.fillHeight: true
                Layout.fillWidth: true
                ListView{
                    id: listview_navi_top
                    property int enterLastIndex : 0
                    property int popLastIndex : 0
                    height: parent.height
                    width: contentWidth
                    model: d.topItems
                    boundsBehavior: ListView.StopAtBounds
                    orientation: ListView.Horizontal
                    delegate: Item{
                        property bool hide: (x+item_top_loader.width-layout_navi_top.width+layout_item_more.width)>0
                        property var currentListView: ListView.view
                        property var modelData : model.modelData
                        property int index: model.index
                        height: ListView.view.height
                        width: item_top_loader.width
                        visible: !hide
                        onHideChanged: {
                            if(hide){
                                d.topCacheItems.push(this)
                            }else{
                                var pos = d.topCacheItems.indexOf(this);
                                if (pos > -1) {
                                    d.topCacheItems.splice(pos, 1);
                                }
                            }
                            d.topCacheItems = d.topCacheItems
                        }
                        clip: true
                        AutoLoader{
                            id: item_top_loader
                            property bool hide: parent.hide
                            property var modelData : parent.modelData
                            property int index: parent.index
                            property var currentListView: parent.currentListView
                            height: parent.height
                            sourceComponent: {
                                if(modelData instanceof PaneItem || modelData instanceof PaneItemExpander){
                                    return comp_navi_top_item
                                }else if(modelData instanceof PaneItemHeader){
                                    return comp_navi_top_header
                                }else if(modelData instanceof PaneItemSeparator){
                                    return comp_navi_top_separator
                                }
                                return undefined
                            }
                        }
                    }
                }
                Item{
                    id: layout_item_more
                    height: listview_navi_top.height
                    width: 50
                    clip: true
                    visible: d.topCacheItems.length !== 0
                    x: Math.min(layout_navi_top.width-50,listview_navi_top.width)
                    IconButton{
                        id: btn_more
                        icon.width: 20
                        icon.height: 20
                        icon.name: FluentIcons.graph_More
                        anchors.centerIn: parent
                        onClicked: {
                            var datas = d.topCacheItems.map(function(item){ return item.modelData })
                            datas = datas.filter(
                                        (item) => {
                                            if(item instanceof PaneItem || item instanceof PaneItemExpander){
                                                if(item.__footer){
                                                    return false
                                                }
                                                return true
                                            }
                                            return false
                                        })
                            d.menuDatas = datas.reverse()
                            menu_pane_items.popup(layout_item_more,0,layout_item_more.height)
                        }
                    }
                }
            }
            Item{
                Layout.fillHeight: true
                Layout.topMargin: 2
                Layout.bottomMargin: 2
                Layout.rightMargin: 4
                Layout.preferredWidth: childrenRect.width
                visible: {
                    if(control.autoSuggestBox){
                        return true
                    }
                    return false
                }
                Item{
                    id: layout_top_autosuggestbox
                    visible: !d.isCompact || d.sideMenuVisible
                    anchors.centerIn: parent
                    width: 200
                    height: childrenRect.height
                    function updateAutoSuggestBox(){
                        if(control.autoSuggestBox && d.displayMode === NavigationViewType.Top){
                            control.autoSuggestBox.parent = layout_top_autosuggestbox
                            control.autoSuggestBox.anchors.left = control.autoSuggestBox.parent.left
                            control.autoSuggestBox.anchors.right = control.autoSuggestBox.parent.right
                        }
                    }
                    Component.onCompleted: {
                        layout_top_autosuggestbox.updateAutoSuggestBox()
                    }
                    Connections{
                        target: d
                        function onDisplayModeChanged() {
                            layout_top_autosuggestbox.updateAutoSuggestBox()
                        }
                    }
                }
            }
            ListView{
                id: listview_navi_top_footer
                Layout.fillHeight: true
                implicitWidth: contentWidth
                model: footerItems
                boundsBehavior: ListView.StopAtBounds
                orientation: ListView.Horizontal
                currentIndex: {
                    if(d.topItems){
                        var footerIndex = listview_navi_top.currentIndex - (d.topItems.length-footerItems.length)
                        if(footerIndex>=0){
                            return footerIndex
                        }
                        return -1
                    }
                    return -1
                }
                delegate: AutoLoader{
                    property var modelData : model.modelData
                    property int index: model.index
                    property var currentListView: ListView.view
                    height: ListView.view.height
                    sourceComponent: {
                        if(modelData instanceof PaneItem || modelData instanceof PaneItemExpander){
                            return comp_navi_top_item
                        }else if(modelData instanceof PaneItemHeader){
                            return comp_navi_top_header
                        }else if(modelData instanceof PaneItemSeparator){
                            return comp_navi_top_separator
                        }
                        return undefined
                    }
                }
            }
        }
    }
    Component{
        id: comp_info_badge
        InfoBadge{
            count: model.count
        }
    }
    Frame{
        id: layout_panne
        anchors{
            left: parent.left
            right: parent.right
            top: d.isTop ? layout_topbar.bottom : layout_appbar.bottom
            bottom: parent.bottom
            leftMargin: {
                if(d.isMinimal || d.isTop){
                    return 0
                }
                if(d.isCompact){
                    return 50
                }
                return sideBarWidth
            }
        }
        Behavior on anchors.leftMargin {
            NumberAnimation{
                duration: Theme.fastAnimationDuration
                easing.type: Theme.animationCurve
            }
        }
        PageRouterView{
            id: stackview_panne
            anchors.fill: parent
            router: control.router
            clip: true
            onCurrentItemChanged: {
                if(d.items){
                    var index = d.items.findIndex((element) => element.key === currentItem.path)
                    if(listview_navi.currentIndex !== index){
                        listview_navi.currentIndex = index
                    }
                    var data = d.items[index]
                    while(data.__parent){
                        if(!data.__parent.__expanded){
                            return 0
                        }
                        data = data.__parent
                    }
                    index = d.topItems.findIndex((element) => element === data)
                    if(listview_navi_top.currentIndex !== index){
                        listview_navi_top.currentIndex = index
                    }
                }
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        visible: d.sideMenuEnabled && d.sideMenuVisible && !d.isTop
        onClicked: {
            d.sideMenuVisible = false
        }
    }
    Shadow{
        id: shadow_side
        anchors.fill: layout_sidebar
        visible: control.sideBarShadow && d.showSideBarBorder
        radius: 7
    }
    Pane{
        id: layout_sidebar
        clip: true
        padding: 0
        width: {
            if(d.isTop){
                return 0
            }
            if(d.sideMenuVisible){
                return sideBarWidth
            }
            if(d.isMinimal){
                return 0
            }
            if(d.isCompact){
                return 50
            }
            return sideBarWidth
        }
        anchors{
            top: parent.top
            bottom: parent.bottom
        }
        Behavior on width{
            NumberAnimation{
                duration: Theme.fastAnimationDuration
                easing.type: Theme.animationCurve
            }
        }
        visible: {
            if(d.isTop){
                return false
            }
            if(d.sideMenuVisible){
                return true
            }
            if(d.isMinimal){
                return false
            }
            return true
        }
        background: Rectangle{
            border.width: d.showSideBarBorder ? 1 : 0
            border.color: control.FluentUI.theme.res.dividerStrokeColorDefault
            radius: d.showSideBarBorder ? 7 : 0
            color: d.sideMenuVisible ? control.FluentUI.theme.res.micaBackgroundColor : Colors.transparent
        }
        Component{
            id: comp_navi_header
            Item{
                visible: {
                    var data = modelData
                    while(data.__parent){
                        if(!data.__parent.__expanded){
                            return false
                        }
                        data = data.__parent
                    }
                    return !(d.isCompact&&!d.sideMenuVisible)
                }
                implicitHeight: visible ? 30 : 0
                Label{
                    text: modelData.title
                    font: Typography.bodyStrong
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 14
                    }
                }
            }
        }
        Component{
            id: comp_navi_separator
            Rectangle{
                implicitHeight: 1
                color: control.FluentUI.theme.res.dividerStrokeColorDefault
            }
        }
        Component{
            id: comp_navi_item
            Item{
                enabled: modelData.enabled
                implicitHeight: {
                    if(modelData instanceof PaneItem){
                        if(modelData.__footer === true && currentListView === listview_navi){
                            return 0
                        }
                    }
                    if(d.isCompact && !d.sideMenuVisible){
                        if(deep !== 0){
                            return 0
                        }else{
                            return control.sideItemHeight
                        }
                    }
                    var data = modelData
                    while(data.__parent){
                        if(!data.__parent.__expanded){
                            return 0
                        }
                        data = data.__parent
                    }
                    return control.sideItemHeight
                }
                property int deep: {
                    var data = modelData
                    var deep = 0
                    while(data.__parent){
                        deep = deep + 1
                        data = data.__parent
                    }
                    return deep
                }
                property bool isCurrentIndex: {
                    if(modelData.__footer){
                        return listview_navi_footer.currentIndex === index
                    }else{
                        return listview_navi.currentIndex === index
                    }
                }
                property bool isHighlight: {
                    if(!d.isCompact || d.sideMenuVisible || modelData.__footer){
                        return isCurrentIndex
                    }
                    if(modelData.__index === listview_navi.currentIndex){
                        return true
                    }
                    if(modelData instanceof PaneItemExpander){
                        const stack = []
                        for(var i=0;i<modelData.children.length;i++){
                            stack.push(modelData.children[i])
                        }
                        while (stack.length > 0) {
                            const current = stack.pop()
                            if(current.__index === listview_navi.currentIndex){
                                return true
                            }
                            if (current instanceof PaneItemExpander) {
                                var children = []
                                for(var j=0;j<current.children.length;j++){
                                    children.push(current.children[j])
                                }
                                for(var k=0;k<children.length;k++){
                                    stack.push(children[k])
                                }
                            }
                        }
                    }
                    return false
                }
                visible: Number(implicitHeight) === control.sideItemHeight
                opacity: visible
                Behavior on implicitHeight{
                    NumberAnimation{
                        duration: Theme.fastAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
                Behavior on opacity {
                    NumberAnimation { duration: 83 }
                }
                Component{
                    id: comp_leading
                    Icon{
                        source: modelData.iconSource
                        width: 18
                        height: 18
                    }
                }
                Component{
                    id: comp_trailing
                    Icon{
                        source: FluentIcons.graph_ChevronUp
                        width: 12
                        height: 12
                        rotation: modelData.__expanded ? 0 : -180
                        Behavior on rotation {
                            NumberAnimation{
                                duration: Theme.fastAnimationDuration
                                easing.type: Theme.animationCurve
                            }
                        }
                    }
                }
                ListTile{
                    id: item_list_tile
                    text: modelData.title
                    highlighted: isCurrentIndex
                    leftPadding: deep * 32 + 12
                    leading: Icon{
                        color: modelData.icon.color
                        source: {
                            if(modelData.icon.source.toString()!==""){
                                return modelData.icon.source
                            }
                            return modelData.icon.name
                        }
                        width: {
                            if(source === ""){
                                return 0
                            }
                            return modelData.icon.width
                        }
                        height: {
                            if(source === ""){
                                return 0
                            }
                            return modelData.icon.height
                        }
                    }
                    trailing: {
                        if(modelData instanceof PaneItemExpander){
                            if(d.isCompact && !d.sideMenuVisible){
                                return null
                            }
                            return comp_trailing
                        }
                        return null
                    }
                    ToolTip{
                        text: modelData.title
                        visible: parent.hovered && d.isCompact && !d.sideMenuVisible
                    }
                    anchors{
                        fill: parent
                        leftMargin: 4
                        rightMargin: 4
                        topMargin: 2
                        bottomMargin: 2
                    }
                    TapHandler{
                        acceptedButtons: Qt.RightButton
                        onTapped: {
                            modelData.rightTap()
                            control.rightTap(modelData)
                        }
                    }
                    TapHandler{
                        onTapped: {
                            if(modelData.__footer){
                                listview_navi.currentIndex = d.items.length - footerItems.length + index
                            }else{
                                listview_navi.currentIndex = index
                            }
                            modelData.tap()
                            control.tap(modelData)
                            if(modelData instanceof PaneItemExpander){
                                modelData.__expanded = !modelData.__expanded
                                if(d.isCompact && !d.sideMenuVisible){
                                    d.showPaneItems(modelData,item_list_tile,item_list_tile.width+4,0)
                                }
                            }else{
                                d.sideMenuVisible = false
                            }
                        }
                    }
                    AutoLoader{
                        property var model: modelData
                        anchors{
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: 8
                        }
                        sourceComponent: {
                            if(modelData instanceof PaneItem){
                                if(modelData.count === 0){
                                    return undefined
                                }
                                if(d.isCompact && !d.sideMenuVisible){
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
                    InfoBadge{
                        dot: true
                        anchors{
                            right: parent.right
                            top: parent.top
                            rightMargin: 5
                            topMargin: 5
                        }
                        visible: {
                            if(modelData instanceof PaneItem){
                                if(modelData.count !== 0 && d.isCompact && !d.sideMenuVisible){
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
                HighlightRectangle{
                    target: listview_navi
                    leftMargin: item_list_tile.leftPadding - 8
                    highlight: isHighlight
                }
            }
        }
        ColumnLayout{
            anchors{
                fill: parent
                topMargin: appBarHeight
            }
            Item{
                visible: d.isCompact
                Layout.fillWidth: true
                Layout.leftMargin: 4
                Layout.rightMargin: 4
                implicitHeight: 36
                IconButton{
                    height: parent.height
                    width: 42
                    icon.width: 16
                    icon.height: 16
                    onClicked: {
                        d.sideMenuVisible = !d.sideMenuVisible
                    }
                    icon.name: FluentIcons.graph_GlobalNavButton
                }
            }
            AutoLoader{
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                sourceComponent: control.leading
                visible: !(d.isCompact && !d.sideMenuVisible && status === Loader.Ready)
            }
            Item{
                Layout.fillWidth: true
                Layout.leftMargin: 4
                Layout.rightMargin: 4
                implicitHeight: childrenRect.height
                visible: {
                    if(control.autoSuggestBox){
                        return true
                    }
                    return false
                }
                Item{
                    id: layout_autosuggestbox
                    anchors{
                        left: parent.left
                        right: parent.right
                        leftMargin: 10
                        rightMargin: 10
                    }
                    visible: !d.isCompact || d.sideMenuVisible
                    function updateAutoSuggestBox(){
                        if(control.autoSuggestBox && d.displayMode !== NavigationViewType.Top){
                            control.autoSuggestBox.parent = layout_autosuggestbox
                            control.autoSuggestBox.anchors.left = control.autoSuggestBox.parent.left
                            control.autoSuggestBox.anchors.right = control.autoSuggestBox.parent.right
                        }
                    }
                    Component.onCompleted: {
                        layout_autosuggestbox.updateAutoSuggestBox()
                    }
                    Connections{
                        target: d
                        function onDisplayModeChanged() {
                            layout_autosuggestbox.updateAutoSuggestBox()
                        }
                    }
                }
                IconButton{
                    height: 36
                    width: 42
                    icon.width: 15
                    icon.height: 15
                    visible: d.isCompact && !d.sideMenuVisible
                    onClicked: {
                        d.sideMenuVisible = true
                    }
                    AutoLoader{
                        anchors.centerIn: parent
                        sourceComponent: control.autoSuggestBoxReplacement
                    }
                }
            }
            Flickable{
                Layout.fillHeight: true
                Layout.fillWidth: true
                boundsBehavior: ListView.StopAtBounds
                contentHeight: listview_navi.contentHeight
                ScrollBar.vertical: ScrollBar {}
                clip: true
                ListView{
                    id: listview_navi
                    property int enterLastIndex : 0
                    property int popLastIndex : 0
                    model: d.items
                    anchors.fill: parent
                    interactive: false
                    boundsBehavior: ListView.StopAtBounds
                    delegate: AutoLoader{
                        property var modelData : model.modelData
                        property int index: model.index
                        property var currentListView: ListView.view
                        width: ListView.view.width
                        sourceComponent: {
                            if(modelData instanceof PaneItem || modelData instanceof PaneItemExpander){
                                return comp_navi_item
                            }else if(modelData instanceof PaneItemHeader){
                                return comp_navi_header
                            }else if(modelData instanceof PaneItemSeparator){
                                return comp_navi_separator
                            }
                            return undefined
                        }
                    }
                    onCurrentIndexChanged: {
                        var data = d.items[currentIndex]
                        if(data){
                            while(data.__parent){
                                if(!data.__parent.__expanded){
                                    data.__parent.__expanded = true
                                }
                                data = data.__parent
                            }
                        }
                    }
                }
            }
            Rectangle{
                Layout.fillWidth: true
                implicitHeight: 1
                color: control.FluentUI.theme.res.dividerStrokeColorDefault
                visible: listview_navi_footer.count !== 0
            }
            AutoLoader{
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                sourceComponent: control.trailing
                visible: !(d.isCompact && !d.sideMenuVisible && status === Loader.Ready)
            }
            ListView{
                id: listview_navi_footer
                model: footerItems
                clip: true
                boundsBehavior: ListView.StopAtBounds
                delegate: AutoLoader{
                    property var modelData : model.modelData
                    property int index: model.index
                    property var currentListView: ListView.view
                    width: ListView.view.width
                    sourceComponent: {
                        if(modelData instanceof PaneItem || modelData instanceof PaneItemExpander){
                            return comp_navi_item
                        }else if(modelData instanceof PaneItemHeader){
                            return comp_navi_header
                        }else if(modelData instanceof PaneItemSeparator){
                            return comp_navi_separator
                        }
                        return undefined
                    }
                }
                implicitHeight: contentHeight
                Layout.fillWidth: true
                currentIndex: {
                    if(d.items){
                        var footerIndex = listview_navi.currentIndex - (d.items.length - footerItems.length)
                        if(footerIndex>=0){
                            return footerIndex
                        }
                        return -1
                    }
                    return -1
                }
            }
        }
    }
    Item{
        id: layout_appbar
        width: parent.width
        height: control.appBarHeight
        RowLayout{
            spacing: 0
            height: 48
            anchors{
                left: parent.left
                leftMargin: 4
                top: parent.top
                topMargin: control.titleBarTopMargin
            }
            IconButton{
                id: button_back
                Layout.alignment: Qt.AlignVCenter
                icon.width: 12
                icon.height: 12
                implicitWidth: 40
                implicitHeight: 36
                enabled: stackview_panne.depth > 1
                onClicked: {
                    stackview_panne.pop()
                }
                icon.name: FluentIcons.graph_ChromeBack
                Component.onCompleted: {
                    d.setHitTestVisible(this)
                }
            }
            IconButton{
                Layout.alignment: Qt.AlignVCenter
                visible: d.isMinimal
                implicitWidth: 40
                implicitHeight: 36
                icon.width: 15
                icon.height: 15
                Layout.rightMargin: 6
                onClicked: {
                    d.sideMenuVisible = !d.sideMenuVisible
                }
                icon.name: FluentIcons.graph_GlobalNavButton
                Component.onCompleted: {
                    d.setHitTestVisible(this)
                }
            }
            Row{
                Layout.fillHeight: true
                Layout.leftMargin: 4
                spacing: 6
                AutoLoader{
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    sourceComponent: logoDelegate
                }
                Label{
                    text: control.title
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    font: Typography.bodyStrong
                }
            }
        }
    }
    Component{
        id: comp_panne
        AutoLoader{
            id: loader_panne
            property var url
            property var argument
            source: visible ? url : null
        }
    }
    NavigationMenu{
        id: menu_pane_items
        Instantiator{
            model: d.menuDatas
            delegate: QtObject{
                property var modelData : model.modelData
                property var parent: menu_pane_items
                property bool isExpander: modelData instanceof PaneItemExpander
                property var value
            }
            onObjectAdded:
                (index, object) => {
                    if(object.isExpander){
                        var component = Qt.createComponent("NavigationMenu.qml");
                        if (component.status === Component.Ready) {
                            var menu = component.createObject(object.parent.contentItem,{modelData:object.modelData,view:control})
                            object.value = menu
                            menu_pane_items.insertMenu(index,menu)
                        }
                    }else{
                        component = Qt.createComponent("NavigationMenuItem.qml");
                        if (component.status === Component.Ready) {
                            var item = component.createObject(object.parent.contentItem,{modelData:object.modelData,view:control})
                            object.value = item
                            menu_pane_items.insertItem(index,item)
                        }
                    }
                }
            onObjectRemoved:
                (index, object) => {
                    if(object.isExpander){
                        menu_pane_items.removeMenu(object.value)
                    }else{
                        menu_pane_items.removeItem(object.value)
                    }
                }
        }
    }
    function go(url,argument={}){
        if(stackview_panne.currentItem){
            if(stackview_panne.currentItem.url === url){
                return
            }
        }
        stackview_panne.push(comp_panne,{url:url,argument:argument})
    }
}
