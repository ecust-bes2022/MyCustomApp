import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

StandardButton {
    id: control
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property string hourText: qsTr("hour")
    property string minuteText: qsTr("minute")
    property string pmText: locale.pmText
    property string amText: locale.amText
    property int hourFormat: TimePickerType.H
    property int minuteIncrement: 1
    property var current
    signal accepted()
    readonly property bool isH: hourFormat === TimePickerType.H
    implicitHeight: 31
    implicitWidth: 240
    topPadding: 0
    bottomPadding: 0
    rightPadding: 1
    leftPadding: 1
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
        property date time: new Date()
        property bool isPm: time.getHours() >= 12
        function formatHour(hour) {
            var date = new Date(0, 0, 0, hour);
            return date.toLocaleTimeString(locale, "HH");
        }
        function formatMinute(minute) {
            var date = new Date(0, 0, 0, 0, minute);
            return date.toLocaleTimeString(locale, "mm");
        }
        function finalHour(hour){
            var finalHour = 0
            if(control.isH && hour > 12){
                finalHour = hour - 12
            }else{
                finalHour = hour
            }
            return finalHour
        }
        Component.onCompleted: {
            if(current){
                d.time = current
            }
        }
    }
    contentItem:  RowLayout{
        spacing: 0
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Label{
                id: label_hour
                text: {
                    if(!control.current){
                        return control.hourText
                    }
                    return d.formatHour(d.finalHour(d.time.getHours()))
                }
                color: control.FluentUI.textColor
                anchors.horizontalCenter: parent.horizontalCenter
                y: (parent.height-height)/2
            }
        }
        Rectangle{
            Layout.fillHeight: true
            implicitWidth: 1
            color: control.FluentUI.theme.res.controlStrokeColorDefault
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Label{
                id: label_minute
                text: {
                    if(!control.current){
                        return control.minuteText
                    }
                    return d.formatMinute(d.time.getMinutes())
                }
                color: control.FluentUI.textColor
                anchors.horizontalCenter: parent.horizontalCenter
                y: (parent.height-height)/2
            }
        }
        Rectangle{
            Layout.fillHeight: true
            implicitWidth: 1
            color: control.FluentUI.theme.res.controlStrokeColorDefault
            visible: control.isH
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: control.isH
            Label{
                id: label_ampm
                text: {
                    if(d.isPm){
                        return control.pmText
                    }
                    return control.amText
                }
                color: control.FluentUI.textColor
                anchors.horizontalCenter: parent.horizontalCenter
                y: (parent.height-height)/2
            }
        }
    }
    onClicked: {
        loader_popup.sourceComponent = comp_popup
    }
    AutoLoader{
        id: loader_popup
    }
    Component{
        id: comp_popup
        DropDownPopup{
            id: popup
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            height: 400
            width: control.width
            Component.onCompleted: {
                popup.popup(control)
            }
            onClosed:{
                loader_popup.sourceComponent = undefined
            }
            content: Item {
                property color hitColor: control.FluentUI.dark ? control.accentColor.lightest() : control.accentColor.darkest()
                property color textColor: Colors.basedOnLuminance(hitColor)
                function formatText(tumbler, modelData) {
                    var data = tumbler === hoursTumbler ? modelData + 1 : modelData;
                    return data.toString().length < 2 ? "0" + data : data;
                }
                function generatePossibleMinutes(minuteIncrement) {
                    var possibleMinutes = [];
                    for (var index = 0; index < 60 / minuteIncrement; index++) {
                        possibleMinutes.push(index * minuteIncrement);
                    }
                    return possibleMinutes;
                }
                function getClosestMinute(possibleMinutes, goal) {
                    if (possibleMinutes.length === 0) {
                        return null;
                    }
                    var closest = possibleMinutes.reduce(function (prev, curr) {
                        return Math.abs(curr - goal) < Math.abs(prev - goal) ? curr : prev;
                    });
                    return clamp(closest, 0, 59)
                }
                function clamp(value, min, max) {
                    return Math.max(min, Math.min(max, value));
                }
                function updatePosition(){
                    var date
                    if(control.current){
                        date = control.current
                    }else{
                        date = new Date()
                    }
                    var h = d.finalHour(date.getHours())
                    if(h === 0){
                        if(control.isH){
                            h = 12
                        }else{
                            h = 24
                        }
                    }
                    var index = -1
                    for(var i=0;i<hoursTumbler.model;i++){
                        if(h === i+1){
                            index = i
                            break
                        }
                    }
                    if(index != -1){
                        hoursTumbler.positionViewAtIndex(index,Tumbler.Center)
                    }
                    index = -1
                    var m = getClosestMinute(minutesTumbler.model,date.getMinutes())
                    for(i=0;i<minutesTumbler.model.length;i++){
                        if(m === minutesTumbler.model[i]){
                            index = i
                            break
                        }
                    }
                    if(index != -1){
                        minutesTumbler.positionViewAtIndex(index,Tumbler.Center)
                    }
                    if(d.isPm){
                        index = 1
                    }else{
                        index = 0
                    }
                    amPmTumbler.positionViewAtIndex(index,Tumbler.Center)
                }
                Connections{
                    target: popup
                    function onOpened(){
                        updatePosition()
                    }
                }
                Component {
                    id: delegateComponent
                    Item{
                        implicitHeight: 40
                        implicitWidth: control.width
                        IconButton{
                            id: tile
                            text: formatText(Tumbler.tumbler, modelData)
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
                }
                ColumnLayout{
                    anchors.fill: parent
                    anchors.margins: 1
                    spacing: 0
                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle{
                            radius: 4
                            height: 40
                            width: parent.width - 8
                            color: hitColor
                            anchors.centerIn: parent
                        }
                        RowLayout {
                            anchors.fill: parent
                            spacing: 0
                            Tumbler {
                                id: hoursTumbler
                                model: control.isH ? 12 : 24
                                delegate: delegateComponent
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                visibleItemCount: 9
                                clip: true
                                Rectangle{
                                    width: parent.width
                                    height: 40
                                    z: 1
                                    color: control.FluentUI.theme.res.popupBackgroundColor
                                    visible: hoursTumbler.hovered
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
                                            var index = hoursTumbler.currentIndex-1
                                            if(index === -1){
                                                index = hoursTumbler.count-1
                                            }
                                            hoursTumbler.currentIndex = index
                                        }
                                    }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: 40
                                    z: 999
                                    anchors.bottom: parent.bottom
                                    color: control.FluentUI.theme.res.popupBackgroundColor
                                    visible: hoursTumbler.hovered
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
                                            var index = hoursTumbler.currentIndex+1
                                            if(index === hoursTumbler.count){
                                                index = 0
                                            }
                                            hoursTumbler.currentIndex = index
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                Layout.fillHeight: true
                                implicitWidth: 1
                                color: control.FluentUI.theme.res.controlStrokeColorDefault
                            }
                            Tumbler {
                                id: minutesTumbler
                                model: generatePossibleMinutes(control.minuteIncrement)
                                delegate: delegateComponent
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                visibleItemCount: 9
                                clip: true
                                Rectangle{
                                    width: parent.width
                                    height: 40
                                    z: 999
                                    color: control.FluentUI.theme.res.popupBackgroundColor
                                    visible: minutesTumbler.hovered
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
                                            var index = minutesTumbler.currentIndex-1
                                            if(index === -1){
                                                index = minutesTumbler.count-1
                                            }
                                            minutesTumbler.currentIndex = index
                                        }
                                    }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: 40
                                    z: 999
                                    anchors.bottom: parent.bottom
                                    color: control.FluentUI.theme.res.popupBackgroundColor
                                    visible: minutesTumbler.hovered
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
                                            var index = minutesTumbler.currentIndex+1
                                            if(index === minutesTumbler.count){
                                                index = 0
                                            }
                                            minutesTumbler.currentIndex = index
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                Layout.fillHeight: true
                                implicitWidth: 1
                                color: control.FluentUI.theme.res.controlStrokeColorDefault
                                visible: control.isH
                            }
                            Tumbler {
                                id: amPmTumbler
                                model: [control.amText, control.pmText]
                                delegate: delegateComponent
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                visibleItemCount: 9
                                visible: control.isH
                                clip: true
                            }
                        }
                    }
                    Rectangle{
                        Layout.fillWidth: true
                        implicitHeight: 1
                        color: control.FluentUI.theme.res.dividerStrokeColorDefault
                    }
                    Item{
                        Layout.fillWidth: true
                        implicitHeight: 40
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
                                        var h = hoursTumbler.currentIndex+1
                                        var m = minutesTumbler.model[minutesTumbler.currentIndex]
                                        var isPm =  amPmTumbler.currentIndex === 1
                                        var finalHour = 0
                                        if(control.isH){
                                            if (isPm) {
                                                finalHour = (h === 12) ? 12 : h + 12
                                            } else {
                                                finalHour = (h === 12) ? 0 : h
                                            }

                                        }else{
                                            finalHour = h
                                        }
                                        var date = new Date()
                                        date.setHours(finalHour)
                                        date.setMinutes(m)
                                        d.time = date
                                        control.current = date
                                        control.accepted()
                                        popup.close()
                                    }
                                }
                            }
                            Rectangle{
                                Layout.fillHeight: true
                                implicitWidth: 1
                                color: control.FluentUI.theme.res.dividerStrokeColorDefault
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
