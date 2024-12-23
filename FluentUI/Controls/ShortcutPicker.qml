import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.impl

StandardButton {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    property var current : ["Ctrl","Shift","A"]
    property string title: qsTr("Activate the Shortcut")
    property string message: qsTr("Press the key combination to change the shortcut")
    property string saveText: qsTr("Save")
    property string cancelText: qsTr("Cancel")
    property string resetText: qsTr("Reset")
    signal accepted()
    text: current.join("+")
    onClicked: {
        loader_dialog.sourceComponent = comp_dialog
    }
    AutoLoader{
        id: loader_dialog
    }
    Component{
        id:com_item_key
        Rectangle{
            color: control.accentColor.defaultBrushFor(control.FluentUI.dark)
            width: Math.max(item_text.implicitWidth+12,28)
            height: Math.max(item_text.implicitHeight,28)
            radius: 4
            Label{
                id: item_text
                text: keyText
                anchors.centerIn: parent
                color: Colors.basedOnLuminance(parent.color)
            }
        }
    }
    Component{
        id: comp_dialog
        Dialog{
            id: dialog_shortcut
            property var keysModel: []
            x: Math.ceil((parent.width - width) / 2)
            y: Math.ceil((parent.height - height) / 2)
            width: 400
            parent: Overlay.overlay
            FluentUI.dark: control.FluentUI.dark
            FluentUI.primaryColor: control.FluentUI.primaryColor
            modal: true
            Component.onCompleted: {
                dialog_shortcut.keysModel = control.current
                dialog_shortcut.open()
            }
            onClosed:{
                loader_dialog.sourceComponent = undefined
            }
            footer: DialogButtonBox{
                Button{
                    text: control.cancelText
                    onClicked: {
                        dialog_shortcut.close()
                    }
                }
                Button{
                    text: control.resetText
                    onClicked: {
                        dialog_shortcut.keysModel = control.current
                    }
                }
                Button{
                    text: control.saveText
                    highlighted: true
                    onClicked: {
                        control.current = dialog_shortcut.keysModel
                        control.accepted()
                        dialog_shortcut.close()
                    }
                }
            }
            title: control.title
            Column{
                width: parent.width
                Label{
                    text: control.message
                }
                Item{
                    implicitWidth: parent.width
                    implicitHeight: 100
                    Component.onCompleted: {
                        forceActiveFocus()
                    }
                    Keys.enabled: true
                    Keys.onPressed:
                        (event)=>{
                            var keyNames = []
                            if (event.modifiers & Qt.AltModifier) {
                                keyNames.push("Alt")
                            }
                            if (event.modifiers & Qt.ControlModifier) {
                                keyNames.push("Ctrl")
                            }
                            if (event.modifiers & Qt.ShiftModifier) {
                                keyNames.push("Shift")
                            }
                            var keyName = dialog_shortcut.keyToString(event.key,false)
                            if(keyName!==""){
                                keyNames.push(keyName)
                                dialog_shortcut.keysModel = keyNames
                            }
                            event.accepted = true
                        }
                    Keys.onTabPressed:
                        (event)=>{
                            event.accepted = true
                        }
                    Row{
                        spacing: 5
                        anchors.centerIn: parent
                        Repeater{
                            model: dialog_shortcut.keysModel
                            delegate: Loader{
                                property var keyText: modelData
                                sourceComponent: com_item_key
                            }
                        }
                    }
                }
            }

            function keyToString(key_code,shift = true)
            {
                switch(key_code)
                {
                case Qt.Key_Period:       return ".";
                case Qt.Key_Greater:      return shift ? ">" : ".";
                case Qt.Key_Comma:        return ",";
                case Qt.Key_Less:         return shift ? "<" : ",";
                case Qt.Key_Slash:        return "/";
                case Qt.Key_Question:     return shift ? "?" : "/";
                case Qt.Key_Semicolon:    return ";";
                case Qt.Key_Colon:        return shift ? ":" : ";";
                case Qt.Key_Apostrophe:   return "'";
                case Qt.Key_QuoteDbl:     return shift ? "'" : "\"";
                case Qt.Key_QuoteLeft:    return "`";
                case Qt.Key_AsciiTilde:   return shift ? "~" : "`";
                case Qt.Key_Minus:        return "-";
                case Qt.Key_Underscore:   return shift ? "_" : "-";
                case Qt.Key_Equal:        return "=";
                case Qt.Key_Plus:         return shift ? "+" : "=";
                case Qt.Key_BracketLeft:  return "[";
                case Qt.Key_BraceLeft:    return shift ? "{" : "[";
                case Qt.Key_BracketRight: return "]";
                case Qt.Key_BraceRight:   return shift ? "}" : "]";
                case Qt.Key_Backslash:    return "\\";
                case Qt.Key_Bar:          return shift ? "|" : "\\";
                case Qt.Key_Up:           return "Up";
                case Qt.Key_Down:         return "Down";
                case Qt.Key_Right:        return "Right";
                case Qt.Key_Left:         return "Left";
                case Qt.Key_Space:        return "Space";
                case Qt.Key_PageDown:     return "PgDown";
                case Qt.Key_PageUp:       return "PgUp";
                case Qt.Key_0:            return "0";
                case Qt.Key_1:            return "1";
                case Qt.Key_2:            return "2";
                case Qt.Key_3:            return "3";
                case Qt.Key_4:            return "4";
                case Qt.Key_5:            return "5";
                case Qt.Key_6:            return "6";
                case Qt.Key_7:            return "7";
                case Qt.Key_8:            return "8";
                case Qt.Key_9:            return "9";
                case Qt.Key_Exclam:       return shift ? "!" : "1";
                case Qt.Key_At:           return shift ? "@" : "2";
                case Qt.Key_NumberSign:   return shift ? "#" : "3";
                case Qt.Key_Dollar:       return shift ? "$" : "4";
                case Qt.Key_Percent:      return shift ? "%" : "5";
                case Qt.Key_AsciiCircum:  return shift ? "^" : "6";
                case Qt.Key_Ampersand:    return shift ? "&" : "7";
                case Qt.Key_Asterisk:     return shift ? "*" : "8";
                case Qt.Key_ParenLeft:    return shift ? "(" : "9";
                case Qt.Key_ParenRight:   return shift ? ")" : "0";
                case Qt.Key_A:            return "A";
                case Qt.Key_B:            return "B";
                case Qt.Key_C:            return "C";
                case Qt.Key_D:            return "D";
                case Qt.Key_E:            return "E";
                case Qt.Key_F:            return "F";
                case Qt.Key_G:            return "G";
                case Qt.Key_H:            return "H";
                case Qt.Key_I:            return "I";
                case Qt.Key_J:            return "J";
                case Qt.Key_K:            return "K";
                case Qt.Key_L:            return "L";
                case Qt.Key_M:            return "M";
                case Qt.Key_N:            return "N";
                case Qt.Key_O:            return "O";
                case Qt.Key_P:            return "P";
                case Qt.Key_Q:            return "Q";
                case Qt.Key_R:            return "R";
                case Qt.Key_S:            return "S";
                case Qt.Key_T:            return "T";
                case Qt.Key_U:            return "U";
                case Qt.Key_V:            return "V";
                case Qt.Key_W:            return "W";
                case Qt.Key_X:            return "X";
                case Qt.Key_Y:            return "Y";
                case Qt.Key_Z:            return "Z";
                case Qt.Key_F1:           return "F1";
                case Qt.Key_F2:           return "F2";
                case Qt.Key_F3:           return "F3";
                case Qt.Key_F4:           return "F4";
                case Qt.Key_F5:           return "F5";
                case Qt.Key_F6:           return "F6";
                case Qt.Key_F7:           return "F7";
                case Qt.Key_F8:           return "F8";
                case Qt.Key_F9:           return "F9";
                case Qt.Key_F10:          return "F10";
                case Qt.Key_F11:          return "F11";
                case Qt.Key_F12:          return "F12";
                case Qt.Key_Home:         return "Home";
                case Qt.Key_End:          return "End";
                case Qt.Key_Insert:       return "Insert";
                case Qt.Key_Delete:       return "Delete";
                }
                return "";
            }
        }
    }

}
