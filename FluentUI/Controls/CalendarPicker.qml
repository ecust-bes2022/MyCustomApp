import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import FluentUI.impl

StandardButton {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    text: {
        if(control.current){
            return control.current.toLocaleDateString(control.locale,"yyyy/M/d")
        }
        return qsTr("Pick a date")
    }
    property date from: new Date(1924, 0, 1)
    property date to: new Date(2124, 11, 31)
    property var current
    signal accepted()
    id:control
    icon.name: FluentIcons.graph_Calendar
    icon.width: 14
    icon.height: 14
    LayoutMirroring.enabled: true
    onClicked: {
        loader_popup.sourceComponent = comp_popup
    }
    Item{
        id:d
        property var window : Window.window
        property date displayDate: {
            if(control.current){
                return control.current
            }
            return new Date()
        }
        property date toDay : new Date()
        property int pageIndex: 0
        signal nextButton
        signal previousButton
        property point yearRing : Qt.point(0,0)
    }
    AutoLoader{
        id: loader_popup
    }
    Component{
        id: comp_popup
        DropDownPopup{
            id:popup
            height: 350
            width: 300
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            Component.onCompleted: {
                popup.popup(control)
            }
            onClosed:{
                loader_popup.sourceComponent = undefined
            }
            CalendarModel {
                id:calender_model
                from: control.from
                to: control.to
            }
            content: Item{
                ColumnLayout  {
                    anchors.fill: parent
                    spacing: 0
                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        RowLayout{
                            anchors.fill: parent
                            spacing: 10
                            Item{
                                Layout.leftMargin: parent.spacing
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                IconButton{
                                    width: parent.width
                                    anchors.centerIn: parent
                                    visible: d.pageIndex === 0
                                    Label{
                                        text: d.displayDate.toLocaleString(control.locale, "MMMM yyyy")
                                        anchors{
                                            verticalCenter: parent.verticalCenter
                                            left: parent.left
                                            leftMargin: 10
                                        }
                                    }
                                    onClicked: {
                                        d.pageIndex = 1
                                    }
                                }
                                IconButton{
                                    width: parent.width
                                    anchors.centerIn: parent
                                    visible: d.pageIndex === 1
                                    Label{
                                        text: d.displayDate.toLocaleString(control.locale, "yyyy")
                                        anchors{
                                            verticalCenter: parent.verticalCenter
                                            left: parent.left
                                            leftMargin: 10
                                        }
                                    }
                                    onClicked: {
                                        d.pageIndex = 2
                                    }
                                }
                                IconButton{
                                    width: parent.width
                                    anchors.centerIn: parent
                                    visible: d.pageIndex === 2
                                    enabled: false
                                    Label{
                                        text: "%1-%2".arg(d.yearRing.x).arg(d.yearRing.y)
                                        anchors{
                                            verticalCenter: parent.verticalCenter
                                            left: parent.left
                                            leftMargin: 10
                                        }
                                    }
                                }
                            }
                            IconButton{
                                id:icon_up
                                icon.name: FluentIcons.graph_CaretUpSolid8
                                icon.width: 10
                                icon.height: 10
                                onClicked: {
                                    d.previousButton()
                                }
                            }
                            IconButton{
                                id:icon_down
                                icon.name: FluentIcons.graph_CaretDownSolid8
                                icon.width: 10
                                icon.height: 10
                                Layout.rightMargin: parent.spacing
                                onClicked: {
                                    d.nextButton()
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: 1
                            color: control.FluentUI.theme.res.dividerStrokeColorDefault
                            anchors.bottom: parent.bottom
                        }
                    }
                    Item{
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        StackView{
                            id:stack_view
                            anchors.fill: parent
                            initialItem: com_page_one
                            replaceEnter : Transition{
                                OpacityAnimator{
                                    from: 0
                                    to: 1
                                    duration: 83
                                }
                                ScaleAnimator{
                                    from: 0.5
                                    to: 1
                                    duration: 167
                                    easing.type: Easing.OutCubic
                                }
                            }
                            replaceExit : Transition{
                                OpacityAnimator{
                                    from: 1
                                    to: 0
                                    duration: 83
                                }
                                ScaleAnimator{
                                    from: 1.0
                                    to: 0.5
                                    duration: 167
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                        Connections{
                            target: d
                            function onPageIndexChanged(){
                                if(d.pageIndex === 0){
                                    stack_view.replace(com_page_one)
                                }
                                if(d.pageIndex === 1){
                                    stack_view.replace(com_page_two)
                                }
                                if(d.pageIndex === 2){
                                    stack_view.replace(com_page_three)
                                }
                            }
                        }
                        Component{
                            id:com_page_three
                            GridView{
                                id:grid_view
                                cellHeight: 75
                                cellWidth: 75
                                clip: true
                                boundsBehavior: GridView.StopAtBounds
                                ScrollBar.vertical: ScrollBar {}
                                model: {
                                    var fromYear = calender_model.from.getFullYear()
                                    var toYear = calender_model.to.getFullYear()
                                    return toYear-fromYear+1
                                }
                                highlightRangeMode: GridView.StrictlyEnforceRange
                                onCurrentIndexChanged:{
                                    var year = currentIndex + calender_model.from.getFullYear()
                                    var start = Math.ceil(year / 10) * 10
                                    var end = start+10
                                    d.yearRing = Qt.point(start,end)
                                }
                                highlightMoveDuration: 100
                                Component.onCompleted: {
                                    grid_view.highlightMoveDuration = 0
                                    currentIndex = d.displayDate.getFullYear()-calender_model.from.getFullYear()
                                    timer_delay.restart()
                                }
                                Connections{
                                    target: d
                                    function onNextButton(){
                                        grid_view.currentIndex = Math.min(grid_view.currentIndex+16,grid_view.count-1)
                                    }
                                    function onPreviousButton(){
                                        grid_view.currentIndex = Math.max(grid_view.currentIndex-16,0)
                                    }
                                }
                                Timer{
                                    id:timer_delay
                                    interval: 100
                                    onTriggered: {
                                        grid_view.highlightMoveDuration = 100
                                    }
                                }
                                currentIndex: -1
                                delegate: Item{
                                    property int year : calender_model.from.getFullYear()+modelData
                                    property bool toYear: year === d.toDay.getFullYear()
                                    implicitHeight: 75
                                    implicitWidth: 75
                                    IconButton{
                                        id:control_delegate
                                        width: 60
                                        height: 60
                                        anchors.centerIn: parent
                                        radius: 30
                                        highlighted: toYear
                                        accentColor: control.accentColor
                                        Label{
                                            text: year
                                            anchors.centerIn: parent
                                            opacity: {
                                                if(toYear){
                                                    return 1
                                                }
                                                if(year >= d.yearRing.x &&  year <= d.yearRing.y){
                                                    return 1
                                                }
                                                if(control_delegate.hovered){
                                                    return 1
                                                }
                                                return 0.3
                                            }
                                            color: {
                                                if(toYear){
                                                    return Colors.white
                                                }
                                                if(control_delegate.pressed){
                                                    return control.FluentUI.dark ? Colors.grey100 : Colors.grey100
                                                }
                                                if(control_delegate.hovered){
                                                    return control.FluentUI.dark ? Colors.grey80 : Colors.grey120
                                                }
                                                return control.FluentUI.dark ? Colors.white : Colors.grey220
                                            }
                                        }
                                        onClicked: {
                                            d.displayDate = new Date(year,0,1)
                                            d.pageIndex = 1
                                        }
                                    }
                                }
                            }
                        }
                        Component{
                            id:com_page_two

                            ListView{
                                id:listview
                                ScrollBar.vertical: ScrollBar {}
                                highlightRangeMode: ListView.StrictlyEnforceRange
                                clip: true
                                boundsBehavior: ListView.StopAtBounds
                                spacing: 0
                                highlightMoveDuration: 100
                                model: {
                                    var fromYear = calender_model.from.getFullYear()
                                    var toYear = calender_model.to.getFullYear()
                                    var yearsArray = []
                                    for (var i = fromYear; i <= toYear; i++) {
                                        yearsArray.push(i)
                                    }
                                    return yearsArray
                                }
                                currentIndex: -1
                                onCurrentIndexChanged:{
                                    var year = model[currentIndex]
                                    var month = d.displayDate.getMonth()
                                    d.displayDate = new Date(year,month,1)
                                }
                                Connections{
                                    target: d
                                    function onNextButton(){
                                        listview.currentIndex = Math.min(listview.currentIndex+1,listview.count-1)
                                    }
                                    function onPreviousButton(){
                                        listview.currentIndex = Math.max(listview.currentIndex-1,0)
                                    }
                                }
                                Component.onCompleted: {
                                    listview.highlightMoveDuration = 0
                                    currentIndex = model.indexOf(d.displayDate.getFullYear())
                                    timer_delay.restart()
                                }
                                Timer{
                                    id:timer_delay
                                    interval: 100
                                    onTriggered: {
                                        listview.highlightMoveDuration = 100
                                    }
                                }
                                delegate: Item{
                                    id:layout_congrol
                                    property int year : modelData
                                    width: listview.width
                                    height: 75*3
                                    GridView{
                                        anchors.fill: parent
                                        cellHeight: 75
                                        cellWidth: 75
                                        clip: true
                                        interactive: false
                                        boundsBehavior: GridView.StopAtBounds
                                        model: 12
                                        delegate: Item{
                                            property int month : modelData
                                            property bool toMonth: layout_congrol.year === d.toDay.getFullYear() && month === d.toDay.getMonth()
                                            implicitHeight: 75
                                            implicitWidth: 75
                                            IconButton{
                                                id:control_delegate
                                                width: 60
                                                height: 60
                                                radius: 30
                                                highlighted: toMonth
                                                accentColor: control.accentColor
                                                anchors.centerIn: parent
                                                Label{
                                                    text: new Date(layout_congrol.year,month).toLocaleString(control.locale, "MMMM")
                                                    anchors.centerIn: parent
                                                    opacity: {
                                                        if(toMonth){
                                                            return 1
                                                        }
                                                        if(layout_congrol.year === d.displayDate.getFullYear()){
                                                            return 1
                                                        }
                                                        if(control_delegate.hovered){
                                                            return 1
                                                        }
                                                        return 0.3
                                                    }
                                                    color: {
                                                        if(toMonth){
                                                            return Colors.white
                                                        }
                                                        if(control_delegate.pressed){
                                                            return control.FluentUI.dark ? Colors.grey100 : Colors.grey100
                                                        }
                                                        if(control_delegate.hovered){
                                                            return control.FluentUI.dark ? Colors.grey80 : Colors.grey120
                                                        }
                                                        return control.FluentUI.dark ? Colors.white : Colors.grey220
                                                    }
                                                }
                                                onClicked: {
                                                    d.displayDate = new Date(layout_congrol.year,month)
                                                    d.pageIndex = 0
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Component{
                            id:com_page_one
                            ColumnLayout  {
                                DayOfWeekRow {
                                    id: dayOfWeekRow
                                    locale: control.locale
                                    font: Typography.body
                                    delegate: Label {
                                        text: model.shortName
                                        font: dayOfWeekRow.font
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    Layout.column: 1
                                    Layout.fillWidth: true
                                }
                                ListView{
                                    id:listview
                                    property bool isCompleted: false
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    highlightRangeMode: ListView.StrictlyEnforceRange
                                    clip: true
                                    boundsBehavior: ListView.StopAtBounds
                                    spacing: 0
                                    highlightMoveDuration: 100
                                    currentIndex: -1
                                    ScrollBar.vertical: ScrollBar {}
                                    onCurrentIndexChanged:{
                                        if(isCompleted){
                                            var month = calender_model.monthAt(currentIndex)
                                            var year = calender_model.yearAt(currentIndex)
                                            d.displayDate = new Date(year,month,1)
                                        }
                                    }
                                    Component.onCompleted: {
                                        listview.model = calender_model
                                        listview.highlightMoveDuration = 0
                                        currentIndex  = calender_model.indexOf(d.displayDate)
                                        timer_delay.restart()
                                        isCompleted = true
                                    }
                                    Timer{
                                        id:timer_delay
                                        interval: 100
                                        onTriggered: {
                                            listview.highlightMoveDuration = 100
                                        }
                                    }
                                    Connections{
                                        target: d
                                        function onNextButton(){
                                            listview.currentIndex = Math.min(listview.currentIndex+1,listview.count-1)
                                        }
                                        function onPreviousButton(){
                                            listview.currentIndex = Math.max(listview.currentIndex-1,0)
                                        }
                                    }
                                    delegate: MonthGrid {
                                        id: grid
                                        width: listview.width
                                        height: listview.height
                                        month: model.month
                                        year: model.year
                                        spacing: 0
                                        locale: control.locale
                                        delegate: Item{
                                            required property bool today
                                            required property int year
                                            required property int month
                                            required property int day
                                            required property int visibleMonth
                                            property color hitColor: control.FluentUI.dark ? control.accentColor.lightest() : control.accentColor.darkest()
                                            visibleMonth: grid.month
                                            IconButton {
                                                id: control_delegate
                                                implicitHeight: 40
                                                implicitWidth: 40
                                                radius: 20
                                                anchors.centerIn: parent
                                                Rectangle{
                                                    width: 34
                                                    height: 34
                                                    radius: width/2
                                                    anchors.centerIn: parent
                                                    color:today ? hitColor : Colors.transparent
                                                }
                                                Rectangle{
                                                    width: 40
                                                    height: 40
                                                    border.width: 1
                                                    anchors.centerIn: parent
                                                    radius: width/2
                                                    border.color: hitColor
                                                    color: Colors.transparent
                                                    visible: {
                                                        if(control.current){
                                                            var y = control.current.getFullYear()
                                                            var m = control.current.getMonth()
                                                            var d =  control.current.getDate()
                                                            if(y === year && m === month && d === day){
                                                                return true
                                                            }
                                                            return false
                                                        }
                                                        return false
                                                    }
                                                }
                                                Label{
                                                    text: day
                                                    opacity: {
                                                        if(today){
                                                            return 1
                                                        }
                                                        if(month === grid.month){
                                                            return 1
                                                        }
                                                        if(control_delegate.hovered){
                                                            return 1
                                                        }
                                                        return 0.3
                                                    }
                                                    anchors.centerIn: parent
                                                    color: {
                                                        if(today){
                                                            return Colors.white
                                                        }
                                                        if(control_delegate.pressed){
                                                            return control.FluentUI.dark ? Colors.grey100 : Colors.grey100
                                                        }
                                                        if(control_delegate.hovered){
                                                            return control.FluentUI.dark ? Colors.grey80 : Colors.grey120
                                                        }
                                                        return control.FluentUI.dark ? Colors.white : Colors.grey220
                                                    }
                                                }
                                                onClicked: {
                                                    control.current = new Date(year,month,day)
                                                    control.accepted()
                                                    popup.close()
                                                }
                                            }
                                        }
                                        background: Item {
                                            x: grid.leftPadding
                                            y: grid.topPadding
                                            width: grid.availableWidth
                                            height: grid.availableHeight
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
