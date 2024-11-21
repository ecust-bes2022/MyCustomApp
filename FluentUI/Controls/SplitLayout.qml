import QtQuick
import QtQuick.Templates as T
import FluentUI.Controls
import FluentUI.impl

T.SplitView {
    id:control
    FluentUI.theme: Theme.of(control)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    QtObject{
        id:d
        property bool isVertical: control.orientation === Qt.Vertical
    }
    handle: Rectangle {
        implicitWidth: d.isVertical ? control.width : 12
        implicitHeight: d.isVertical ? 12 : control.height
        clip: true
        color:{
            if(!control.enabled){
                return control.FluentUI.theme.res.controlFillColorDisabled
            }else{
                if(T.SplitHandle.pressed){
                    return control.FluentUI.theme.res.subtleFillColorTertiary
                }
                if(T.SplitHandle.hovered){
                    return control.FluentUI.theme.res.subtleFillColorSecondary
                }
                return control.FluentUI.theme.res.subtleFillColorTransparent
            }
        }
        Rectangle{
            width: d.isVertical ? 26 : 4
            height: d.isVertical ? 4 : 26
            anchors.centerIn: parent
            color: control.FluentUI.theme.res.controlStrongStrokeColorDefault
            radius: 2
        }
    }
}
