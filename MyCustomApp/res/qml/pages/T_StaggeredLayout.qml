import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ContentPage{
    title: qsTr("StaggeredLayout")
    property var colors : [Colors.yellow,Colors.orange,Colors.red,Colors.magenta,Colors.purple,Colors.blue,Colors.teal,Colors.green]
    ListModel{
        id:list_model
        Component.onCompleted: {
            for(var i=0;i<=100;i++){
                var item = {}
                item.color = colors[rand(0,7)]
                item.height = rand(100,300)
                append(item)
            }
        }
    }
    Flickable{
        id: scroll
        anchors.fill: parent
        boundsBehavior:Flickable.StopAtBounds
        contentHeight: staggered_view.implicitHeight
        clip: true
        ScrollBar.vertical: ScrollBar {}
        StaggeredLayout{
            id:staggered_view
            width: parent.width
            itemWidth: 160
            model:list_model
            delegate: Rectangle{
                height: model.height
                color:model.color.normal
                Label{
                    color:"#FFFFFF"
                    text:model.index
                    font: Typography.title
                    anchors.centerIn: parent
                }
            }
        }
    }
    function rand(minNum, maxNum){
        return parseInt(Math.random() * (maxNum - minNum + 1) + minNum, 10);
    }
}
