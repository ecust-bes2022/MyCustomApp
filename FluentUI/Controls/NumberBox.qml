import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

TextBox {
    id: control
    FluentUI.theme: Theme.of(control)
    property int placementMode: NumberBoxType.Inline
    property var min: null
    property var max: null
    property var value: null
    property real smallChange: 1
    property real largeChange: 2
    property int precision: 2
    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset)
    trailing: {
        if(placementMode === NumberBoxType.Inline){
            return comp_inline
        }
        return comp_compact
    }
    QtObject{
        id: d
        property var previousValidValue: control.value
        function format(value, precision) {
            if (value === null || value === undefined) return null;
            if (typeof value === 'number' && Number.isInteger(value)) {
                return value;
            }
            var mul = Math.pow(10, precision);
            return (Math.round(value * mul) / mul).toFixed(precision);
        }
        function isInteger(text) {
            var integerRegex = /^-?\d+$/;
            return integerRegex.test(text);
        }
        function isDouble(text) {
            var doubleRegex = /^-?\d+(\.\d+)?$/;
            return doubleRegex.test(text);
        }
        function updateValue(){
            var value
            if(control.text !== ""){
                value = d.tryParse(control.text)
                if(value === null){
                    value = previousValidValue
                }
                if (value !== null && control.max != null && value > control.max) {
                    value = control.max
                } else if (value !== null && control.min !== null && value < control.min) {
                    value = control.min
                }
                control.text = d.format(value,control.precision)
                previousValidValue = value
                control.value = value
                if(control.text === String(control.min) || control.text === String(control.max)){
                    control.selectAll()
                }
            }
        }
        function tryParse(text) {
            if(isInteger(text)){
                return parseInt(text)
            }else if(isDouble(text)){
                return parseFloat(text)
            }
            return null
        }
    }
    onEditingFinished: {
        d.updateValue()
    }
    onActiveFocusChanged: {
        if(activeFocus){
            control.selectAll()
        }
    }
    WheelHandler {
        enabled: control.activeFocus
        onWheel:
            (event)=> {
                if (event.angleDelta.y > 0) {
                    smallIncrement()
                } else {
                    smallDecrement()
                }
            }
    }
    Component.onCompleted: {
        if(value === null){
            control.text = ""
        }else{
            control.text = String(control.value)
        }
    }
    Keys.onPressed:
        (event)=> {
            switch (event.key) {
                case Qt.Key_PageUp:
                control.largeIncrement()
                break
                case Qt.Key_PageDown:
                control.largeDecrement()
                break
                case Qt.Key_Up:
                control.smallIncrement()
                break
                case Qt.Key_Down:
                control.smallDecrement()
                break
                default:
                break
            }
        }
    background: InputBackground {
        implicitWidth: 130
        implicitHeight: 32
        radius: control.FluentUI.radius
        activeColor: control.accentColor.defaultBrushFor(control.FluentUI.dark)
        color: {
            if(!control.enabled){
                return control.FluentUI.theme.res.controlFillColorDisabled
            }else if(control.activeFocus){
                return control.FluentUI.theme.res.controlFillColorInputActive
            }else if(control.hovered){
                return control.FluentUI.theme.res.controlFillColorSecondary
            }else{
                return control.FluentUI.theme.res.controlFillColorDefault
            }
        }
        target: control
    }
    Component{
        id: comp_compact
        Item{
            implicitWidth: 20
            implicitHeight: 24
            Icon{
                source: FluentIcons.graph_ChevronUp
                width: 10
                height: 10
                x: (parent.width - width)/2
                y: (parent.height - height)/2 - 4
                color: control.FluentUI.theme.res.textFillColorSecondary
            }
            Icon{
                source: FluentIcons.graph_ChevronDown
                width: 10
                height: 10
                x: (parent.width - width)/2
                y: (parent.height - height)/2 + 4
                color: control.FluentUI.theme.res.textFillColorSecondary
            }
            DropDownPopup{
                width: 50
                height: 90
                dim: false
                modal: false
                visible: control.activeFocus
                FluentUI.dark: control.FluentUI.dark
                FluentUI.primaryColor: control.FluentUI.primaryColor
                content: Item{
                    ColumnLayout{
                        anchors.fill: parent
                        IconButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.margins: 4
                            icon.name: FluentIcons.graph_ChevronUp
                            icon.width: 14
                            icon.height: 14
                            autoRepeat: true
                            onClicked: {
                                control.smallIncrement()
                            }
                        }
                        IconButton{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.margins: 4
                            icon.name: FluentIcons.graph_ChevronDown
                            icon.width: 14
                            icon.height: 14
                            autoRepeat: true
                            onClicked: {
                                control.smallDecrement()
                            }
                        }
                    }
                }
                animationEnabled: false
                closePolicy: Popup.NoAutoClose
                x: 0
                y: -(height-parent.height)/2
            }
        }
    }
    Component{
        id: comp_inline
        Row{
            IconButton{
                implicitWidth: 30
                implicitHeight: 20
                icon.name: FluentIcons.graph_Cancel
                icon.width: 12
                icon.height: 12
                visible: control.text !== ""
                onClicked: {
                    control.clear()
                }
            }
            IconButton{
                implicitWidth: 30
                implicitHeight: 20
                icon.name: FluentIcons.graph_ChevronUp
                icon.width: 12
                icon.height: 12
                autoRepeat: true
                onClicked: {
                    control.smallIncrement()
                    control.forceActiveFocus()
                }
            }
            IconButton{
                implicitWidth: 30
                implicitHeight: 20
                icon.name: FluentIcons.graph_ChevronDown
                icon.width: 12
                icon.height: 12
                autoRepeat: true
                onClicked: {
                    control.smallDecrement()
                    control.forceActiveFocus()
                }
            }
        }
    }
    function smallIncrement(){
        var current = d.tryParse(text)
        if(current === null){
            current = 0
        }
        const value = current + control.smallChange
        text = value
        d.updateValue()
    }
    function smallDecrement(){
        var current = d.tryParse(text)
        if(current === null){
            current = 0
        }
        const value = current - control.smallChange
        text = value
        d.updateValue()
    }
    function largeIncrement(){
        var current = d.tryParse(text)
        if(current === null){
            current = 0
        }
        const value = current + control.largeChange
        text = value
        d.updateValue()
    }
    function largeDecrement(){
        var current = d.tryParse(text)
        if(current === null){
            current = 0
        }
        const value = current - control.largeChange
        text = value
        d.updateValue()
    }

}
