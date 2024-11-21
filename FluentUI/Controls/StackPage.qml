import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.impl

ContentPage {
    id: control
    padding: 0
    FluentUI.theme: Theme.of(control)
    property PageRouter router
    property alias popEnter: stack_view.popEnter
    property alias popExit: stack_view.popExit
    property alias pushEnter: stack_view.pushEnter
    property alias pushExit: stack_view.pushExit
    property alias replaceEnter: stack_view.replaceEnter
    property alias replaceExit: stack_view.replaceExit
    header: Item{
        width: parent.width
        height: 60
        Breadcrumb{
            id: breadcrumb
            height: 36
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 24
                leftMargin: 24
                rightMargin: 24
            }
            spacing: 12
            moreSize: 32
            moreSpacing: 12
            font: Typography.title
            separator: Icon{
                source: FluentIcons.graph_ChevronRightMed
                implicitHeight: 20
                implicitWidth: 20
                color: control.FluentUI.theme.res.textFillColorTertiary
            }
            items: {
                var data = []
                for(var i=0;i<stack_view.depth;i++){
                    var loader = stack_view.get(i)
                    if(loader){
                        data.push({title:loader.title})
                    }
                }
                return data
            }
            onClickItem:
                (model)=>{
                    if(model.index+1!==count()){
                        control.popToIndex(model.index)
                    }
                }
        }
    }
    function popToIndex(index){
        if (index < 0 || index >= stack_view.depth) {
            console.warn("Index out of range")
            return;
        }
        while (stack_view.depth > index + 1) {
            stack_view.pop()
        }
    }
    PageRouterView{
        id: stack_view
        anchors.fill: parent
        router: control.router
        skipCurrentCheck: true
        component LineAnimation: NumberAnimation {
            duration: Theme.fastAnimationDuration
            easing.type: Theme.animationCurve
        }
        popEnter: Transition {
            LineAnimation { property: "x"; from: (control.mirrored ? -1.0 : 1.0) *  -control.width; to: 0 }
        }
        popExit: Transition {
            LineAnimation { property: "x"; from: 0; to: (control.mirrored ? -1.0 : 1.0) * control.width }
        }
        pushEnter: Transition {
            LineAnimation { property: "x"; from: (control.mirrored ? -1.0 : 1.0) * control.width; to: 0 }
        }
        pushExit: Transition {
            LineAnimation { property: "x"; from: 0; to: (control.mirrored ? -1.0 : 1.0) * -control.width }
        }
        replaceEnter: Transition {
            LineAnimation { property: "x"; from: (control.mirrored ? -1.0 : 1.0) * control.width; to: 0 }
        }
        replaceExit: Transition {
            LineAnimation { property: "x"; from: 0; to: (control.mirrored ? -1.0 : 1.0) * -control.width }
        }
    }
}
