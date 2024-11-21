import QtQuick
import QtQuick.Layouts
import FluentUI.impl

TextBox {
    id: control
    echoMode: TextInput.Password
    trailing: IconButton{
        id: btn_reveal
        property int echoMode: 0
        implicitWidth: 30
        implicitHeight: 20
        icon.name: FluentIcons.graph_RevealPasswordMedium
        icon.width: 10
        icon.height: 10
        onPressedChanged: {
            if(pressed){
                btn_reveal.echoMode = control.echoMode
                control.echoMode = TextInput.Normal
            }else{
                control.echoMode = btn_reveal.echoMode
            }
        }
    }
}
