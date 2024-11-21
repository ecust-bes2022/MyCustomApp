import QtQuick
import QtQuick.Controls
import FluentUI.impl

Item {
    FluentUI.theme: Theme.of(control)
    property var accentColor: FluentUI.theme.accentColor
    property int number: 5
    property int spacing: 4
    property int size: 18
    property int value:0
    id:control
    implicitWidth: container.width
    implicitHeight: container.height
    QtObject{
        id:d
        property int mouseValue: 0
        property int itemSize: control.size+spacing*2
    }
    Row{
        id:container
        spacing: 0
        Repeater{
            model:control.number
            Item{
                width: d.itemSize
                height: d.itemSize
                Icon{
                    property bool seleted : {
                        if(d.mouseValue!==0){
                            return index<d.mouseValue
                        }
                        return index<control.value
                    }
                    width: control.size
                    height: control.size
                    source: seleted ? FluentIcons.graph_FavoriteStarFill : FluentIcons.graph_FavoriteStar
                    color: seleted ? control.accentColor.defaultBrushFor(control.FluentUI.dark) : control.FluentUI.theme.res.textFillColorPrimary
                    anchors.centerIn: parent
                }
            }
        }
    }
    MouseArea{
        anchors.fill: container
        hoverEnabled: true
        onPositionChanged: (mouse)=>{
            d.mouseValue = Number(mouse.x / d.itemSize)+1
        }
        onExited: {
            d.mouseValue = 0
        }
        onClicked: (mouse)=>{
            control.value = Number(mouse.x / d.itemSize)+1
        }
    }
}
