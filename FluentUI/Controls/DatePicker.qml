import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

StandardButton {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    id: control
    property string yearText: qsTr("year")
    property string monthText: qsTr("month")
    property string dayText: qsTr("day")
    property var current
    signal accepted()
    property bool showYear: true
    property bool showMonth: true
    property bool showDay: true
    property date startDate: new Date(1924, 0, 1)
    property date endDate: new Date(2124, 0, 1)
    implicitHeight: 31
    implicitWidth: 326
    topPadding: 0
    bottomPadding: 0
    rightPadding: 0
    leftPadding: 0
    FluentUI.textColor: {
        if(!control.enabled){
            return control.FluentUI.theme.res.textFillColorDisabled
        }
        if(control.pressed){
            return control.FluentUI.theme.res.textFillColorSecondary
        }
        return control.FluentUI.theme.res.textFillColorPrimary
    }
    QtObject{
        id: d
        property date localDate: new Date()
        property int currentYear: localDate.getFullYear()
        property int currentMonth: localDate.getMonth()
        property int currentDay: localDate.getDate()
        property int startYear: control.startDate.getFullYear()
        property int endYear: control.endDate.getFullYear()
        property var fieldModel: {
            var fieldOrder = getDateOrderFromLocale(control.locale)
            var fieldFlex = getDateFlexFromLocale(control.locale)
            var flexSum = 0
            var data = []
            for(var i = 0; i<fieldOrder.length;i++){
                var obj = {}
                obj.order = fieldOrder[i]
                obj.flex =  fieldFlex[i]
                switch (obj.order) {
                case DatePickerType.Day:
                    if(!control.showDay){
                        obj.flex = 0
                    }
                    break
                case DatePickerType.Month:
                    if(!control.showMonth){
                        obj.flex = 0
                    }
                    break
                case DatePickerType.Year:
                    if(!control.showYear){
                        obj.flex = 0
                    }
                    break
                default:
                    return ""
                }
                flexSum=flexSum+obj.flex
                if(obj.flex!==0){
                    data.push(obj)
                }
            }
            for(i = 0; i<data.length;i++){
                var item = data[i]
                if(flexSum === 0){
                    item.widthPercent = 0
                }else{
                    item.widthPercent = item.flex/flexSum
                }
            }
            return data
        }
        function getDateOrderFromLocale(locale){
            const dmy = [
                          DatePickerType.Day,
                          DatePickerType.Month,
                          DatePickerType.Year,
                      ];
            const ymd = [
                          DatePickerType.Year,
                          DatePickerType.Month,
                          DatePickerType.Day,
                      ];
            const mdy = [
                          DatePickerType.Month,
                          DatePickerType.Day,
                          DatePickerType.Year,
                      ];
            var data = locale.name.split("_")
            var lang = data[0]
            var country = data[1]
            if(country === "US"){
                return mdy
            }
            if(["zh", "ko", "jp"].indexOf(lang) !== -1){
                return ymd
            }
            return dmy
        }
        function getDateFlexFromLocale(locale){
            var data = locale.name.split("_")
            var lang = data[0]
            var country = data[1]
            if(country === "US"){
                return [2, 1, 1]
            }
            if(["zh", "ko"].indexOf(lang) !== -1){
                return [1, 1, 1]
            }
            return [1, 2, 1]
        }
        function widthPercent(dateField){
            var index = fieldOrder.findIndex(dateField)
        }
        function monthsInYear(currentYear, startDate, endDate) {
            var result = []
            for (var i = 1; i <= 12; i++) {
                result.push(i)
            }
            return result
        }
        function getDaysInMonth(month, year) {
            var currentDate = new Date(year,month)
            year = year || currentDate.getFullYear()
            month = month || currentDate.getMonth()
            var start = new Date(year, month, 1)
            var end = new Date(year, month+1, 1)
            var duration = (end - start) / (1000 * 60 * 60 * 24);
            return duration
        }
        function formatMonth(date){
            return date.toLocaleDateString(control.locale, "MMMM")
        }
    }
    Component {
        id: comp_field
        Item{
            property bool isMonth: modelData.order === DatePickerType.Month
            property var name: {
                switch (modelData.order) {
                case DatePickerType.Day:
                    if(!control.current){
                        return control.dayText
                    }
                    return control.current.getDate()
                case DatePickerType.Month:
                    if(!control.current){
                        return control.monthText
                    }
                    return d.formatMonth(control.current)
                case DatePickerType.Year:
                    if(!control.current){
                        return control.yearText
                    }
                    return control.current.getFullYear()
                default:
                    return ""
                }
            }
            Label{
                text: name
                anchors{
                    horizontalCenter: isMonth ? undefined : parent.horizontalCenter
                    left: isMonth ? parent.left : undefined
                    leftMargin: isMonth ? 12 : 0
                }
                color: control.FluentUI.textColor
                y: (parent.height-height)/2
            }
            Rectangle{
                height: parent.height
                width: 1
                color: control.FluentUI.theme.res.controlStrokeColorDefault
                anchors.right: parent.right
                visible: index !== (d.fieldModel.length - 1)
            }
        }
    }
    contentItem: RowLayout{
        spacing: 0
        Repeater{
            model: d.fieldModel
            delegate: AutoLoader{
                Layout.fillHeight: true
                clip: true
                width: control.width * modelData.widthPercent
                property var modelData: model.modelData
                property var index: model.index
                sourceComponent: comp_field
            }
        }
    }
    onClicked: {
        loader_popup.sourceComponent = comp_popup
    }
    AutoLoader{
        id: loader_popup
    }
    Component {
        id: comp_popup
        DropDownPopup{
            id: popup
            height: 400
            width: control.width
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            Component.onCompleted: {
                popup.popup(control)
            }
            onClosed:{
                loader_popup.sourceComponent = undefined
            }
            content: Item {
                id: layout_root
                property color hitColor: control.FluentUI.dark ? control.accentColor.lightest() : control.accentColor.darkest()
                property color textColor: Colors.basedOnLuminance(hitColor)
                property int yearModel: d.endYear-d.startYear+1
                property var monthModel: d.monthsInYear(d.currentYear,control.startDate,control.endDate)
                property var dayModel: d.getDaysInMonth(d.currentMonth,d.currentYear)
                signal updateYearIndexChanged(int index)
                signal updateMonthIndexChanged(int index)
                signal updateDayIndexChanged(int index)
                function updatePosition(){
                    var date
                    if(control.current){
                        date = control.current
                    }else{
                        date = new Date()
                    }
                    var index = -1
                    var year = date.getFullYear()
                    index = year - d.startYear
                    if(index >= -1){
                        updateYearIndexChanged(index)
                    }
                    index = -1
                    var month = date.getMonth()+1
                    index = monthModel.findIndex(function(element){ return element === month })
                    if(index >= -1){
                        updateMonthIndexChanged(index)
                    }
                    index = -1
                    var day = date.getDate()
                    index = day - 1
                    if(index >= 0){
                        updateDayIndexChanged(index)
                    }
                }
                Connections{
                    target: popup
                    function onOpened(){
                        updatePosition()
                    }
                }
                Component {
                    id: comp_year
                    Tumbler {
                        id: yearTumbler
                        model: yearModel
                        delegate: Item{
                            property int realYear: d.startYear+model.index
                            implicitHeight: 40
                            implicitWidth: 200
                            IconButton{
                                text: realYear
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                FluentUI.textColor: model.index === Tumbler.tumbler.currentIndex? textColor : control.FluentUI.theme.res.textFillColorPrimary
                                onClicked: {
                                    Tumbler.tumbler.currentIndex = model.index
                                }
                            }
                        }
                        visibleItemCount: 9
                        clip: true
                        onCurrentIndexChanged: {
                            d.currentYear = d.startYear+currentIndex
                        }
                        Connections{
                            target: layout_root
                            function onUpdateYearIndexChanged(index){
                                yearTumbler.positionViewAtIndex(index,Tumbler.Center)
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: yearTumbler.hovered
                            radius: 4
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretUpSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = yearTumbler.currentIndex-1
                                    if(index === -1){
                                        index = yearTumbler.count-1
                                    }
                                    yearTumbler.currentIndex = index
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            radius: 4
                            anchors.bottom: parent.bottom
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: yearTumbler.hovered
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretDownSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = yearTumbler.currentIndex+1
                                    if(index === yearTumbler.count){
                                        index = 0
                                    }
                                    yearTumbler.currentIndex = index
                                }
                            }
                        }
                        Rectangle{
                            implicitHeight: parent.height
                            implicitWidth: 1
                            color: control.FluentUI.theme.res.controlStrokeColorDefault
                            anchors.right: parent.right
                            z: 2
                            visible: index !== d.fieldModel.length-1
                        }
                    }
                }
                Component {
                    id: comp_month
                    Tumbler {
                        id: monthTumbler
                        model: monthModel
                        delegate: Item{
                            property int realMonth: modelData
                            implicitHeight: 40
                            implicitWidth: 200
                            IconButton{
                                id: button
                                text: d.formatMonth(new Date(1,realMonth-1))
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                FluentUI.textColor: model.index === Tumbler.tumbler.currentIndex? textColor : control.FluentUI.theme.res.textFillColorPrimary
                                onClicked: {
                                    Tumbler.tumbler.currentIndex = model.index
                                }
                                leftPadding: 8
                                contentItem: Item{
                                    Label{
                                        text: button.text
                                        font: button.font
                                        color: button.FluentUI.textColor
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                        }
                        visibleItemCount: 9
                        clip: true
                        onCurrentIndexChanged: {
                            d.currentMonth = model[currentIndex] - 1
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: monthTumbler.hovered
                            radius: 4
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretUpSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = monthTumbler.currentIndex-1
                                    if(index === -1){
                                        index = monthTumbler.count-1
                                    }
                                    monthTumbler.currentIndex = index
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            radius: 4
                            anchors.bottom: parent.bottom
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: monthTumbler.hovered
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretDownSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = monthTumbler.currentIndex+1
                                    if(index === monthTumbler.count){
                                        index = 0
                                    }
                                    monthTumbler.currentIndex = index
                                }
                            }
                        }
                        Connections{
                            target: layout_root
                            function onUpdateMonthIndexChanged(index){
                                monthTumbler.positionViewAtIndex(index,Tumbler.Center)
                            }
                        }
                        Rectangle{
                            implicitHeight: parent.height
                            implicitWidth: 1
                            color: control.FluentUI.theme.res.controlStrokeColorDefault
                            anchors.right: parent.right
                            visible: index !== d.fieldModel.length-1
                            z: 2
                        }
                    }
                }
                Component {
                    id: comp_day
                    Tumbler {
                        id: dayTumbler
                        model: dayModel
                        delegate: Item{
                            property int realDay: model.index + 1
                            implicitHeight: 40
                            implicitWidth: 200
                            IconButton{
                                text: realDay
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                FluentUI.textColor: model.index === Tumbler.tumbler.currentIndex? textColor : control.FluentUI.theme.res.textFillColorPrimary
                                onClicked: {
                                    Tumbler.tumbler.currentIndex = model.index
                                }
                            }
                        }
                        visibleItemCount: 9
                        clip: true
                        onCurrentIndexChanged: {
                            d.currentDay = currentIndex+1
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: dayTumbler.hovered
                            radius: 4
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretUpSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = dayTumbler.currentIndex-1
                                    if(index === -1){
                                        index = dayTumbler.count-1
                                    }
                                    dayTumbler.currentIndex = index
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: 40
                            z: 1
                            radius: 4
                            anchors.bottom: parent.bottom
                            color: control.FluentUI.theme.res.popupBackgroundColor
                            visible: dayTumbler.hovered
                            IconButton{
                                anchors{
                                    fill: parent
                                    margins: 4
                                }
                                background: Item{}
                                icon.name: FluentIcons.graph_CaretDownSolid8
                                icon.width: 8
                                icon.height: 8
                                scale: pressed ? 0.85 : 1
                                onClicked: {
                                    var index = dayTumbler.currentIndex+1
                                    if(index === dayTumbler.count){
                                        index = 0
                                    }
                                    dayTumbler.currentIndex = index
                                }
                            }
                        }
                        Connections{
                            target: layout_root
                            function onUpdateDayIndexChanged(index){
                                dayTumbler.positionViewAtIndex(index,Tumbler.Center)
                            }
                        }
                        Rectangle{
                            implicitHeight: parent.height
                            implicitWidth: 1
                            color: control.FluentUI.theme.res.controlStrokeColorDefault
                            anchors.right: parent.right
                            visible: index !== d.fieldModel.length-1
                            z: 2
                        }
                    }
                }
                Item{
                    id: layout_content
                    anchors.fill: parent
                    anchors.margins: 1
                    anchors.centerIn: parent
                    Rectangle{
                        radius: 4
                        height: 40
                        width: parent.width - 8
                        color: hitColor
                        anchors.centerIn: layout_row
                    }
                    RowLayout{
                        id: layout_row
                        anchors{
                            fill: parent
                            bottomMargin: 40
                        }
                        spacing: 0
                        Repeater{
                            model: d.fieldModel
                            delegate: AutoLoader{
                                Layout.fillHeight: true
                                Layout.preferredWidth: layout_content.width * modelData.widthPercent
                                clip: true
                                property var modelData: model.modelData
                                property var index: model.index
                                sourceComponent: {
                                    switch (modelData.order) {
                                    case DatePickerType.Day:
                                        return comp_day
                                    case DatePickerType.Month:
                                        return comp_month
                                    case DatePickerType.Year:
                                        return comp_year
                                    default:
                                        return undefined
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: 1
                        color: control.FluentUI.theme.res.dividerStrokeColorDefault
                        z:99
                        anchors{
                            bottom: parent.bottom
                            bottomMargin: 40
                        }
                    }
                    Item{
                        width: parent.width
                        height: 40
                        anchors{
                            bottom: parent.bottom
                        }
                        RowLayout{
                            anchors.fill: parent
                            spacing: 0
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                IconButton{
                                    anchors{
                                        fill: parent
                                        margins: 4
                                    }
                                    icon.name: FluentIcons.graph_Accept
                                    icon.width: 15
                                    icon.height: 15
                                    onClicked: {
                                        control.current = new Date(d.currentYear,d.currentMonth,d.currentDay)
                                        control.accepted()
                                        popup.close()
                                    }
                                }
                                Rectangle{
                                    implicitHeight: parent.height
                                    implicitWidth: 1
                                    color: control.FluentUI.theme.res.dividerStrokeColorDefault
                                    anchors.right: parent.right
                                }
                            }
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                IconButton{
                                    anchors{
                                        fill: parent
                                        margins: 4
                                    }
                                    icon.name: FluentIcons.graph_Cancel
                                    icon.width: 15
                                    icon.height: 15
                                    onClicked: {
                                        popup.close()
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
