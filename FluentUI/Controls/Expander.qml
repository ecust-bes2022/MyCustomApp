import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import FluentUI.impl

Item {
    FluentUI.theme: Theme.of(control)
    property bool expanded: false
    property Component content
    property Component header: comp_header
    property Component leading
    property Component trailing
    property string title
    id:control
    implicitHeight: Math.max((layout_control.height + layout_container.height),layout_control.height)
    implicitWidth: 400
    QtObject{
        id:d
        property bool flag: false
        property int contentHeight: Math.max(loader_content.height,48)
        function toggle(){
            d.flag = true
            expanded = !expanded
            d.flag = false
        }
    }
    Component{
        id: comp_header
        Label{
            text: control.title
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }
    }
    clip: true
    Button{
        id: layout_control
        width: parent.width
        height: 48
        FluentUI.radius: 6
        activeFocusOnTab: true
        Keys.onSpacePressed: {
            d.toggle()
        }
        onClicked: {
            d.toggle()
        }
        RowLayout{
            anchors.fill: parent
            spacing: 0
            Loader{
                Layout.fillHeight: true
                sourceComponent: control.header
                Layout.leftMargin: 20
            }
            Loader{
                Layout.fillHeight: true
                sourceComponent: control.leading
                Layout.leftMargin: 10
                visible: sourceComponent !== undefined
            }
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Loader{
                sourceComponent: control.trailing
                Layout.leftMargin: 8
                Layout.alignment: Qt.AlignVCenter
                visible: sourceComponent !== undefined
            }
            Item{
                implicitWidth: 50
                Layout.fillHeight: true
                IconButton{
                    id: btn_icon
                    anchors.centerIn: parent
                    width: 30
                    height: 30
                    Icon{
                        anchors.centerIn: parent
                        rotation: expanded ? 0 : -180
                        source: FluentIcons.graph_ChevronUp
                        width: 15
                        height: 15
                        color: control.enabled ? control.FluentUI.theme.res.textFillColorPrimary : control.FluentUI.theme.res.textFillColorDisabled
                        Behavior on rotation {
                            NumberAnimation{
                                duration: Theme.fastAnimationDuration
                                easing.type: Theme.animationCurve
                            }
                        }
                    }
                    onClicked: {
                        d.toggle()
                    }
                }
            }
        }
    }
    Item{
        id:layout_container
        anchors{
            top: layout_control.bottom
            topMargin: -1
            left: layout_control.left
        }
        visible: d.contentHeight+container.anchors.topMargin !== 0
        height: d.contentHeight+container.anchors.topMargin
        width: parent.width
        z:-999
        clip: true
        Rectangle{
            id:container
            anchors.fill: parent
            radius: 6
            clip: true
            border.color: control.FluentUI.theme.res.cardStrokeColorDefault
            color: control.FluentUI.theme.res.cardBackgroundFillColorSecondary
            anchors.topMargin: -d.contentHeight
            Loader{
                id: loader_content
                width: parent.width
                sourceComponent: {
                    if(control.expanded){
                        return control.content
                    }
                    return undefined
                }
            }
            states: [
                State{
                    name:"expand"
                    when: control.expanded
                    PropertyChanges {
                        target: container
                        anchors.topMargin:0
                    }
                },
                State{
                    name:"collapsed"
                    when: !control.expanded
                    PropertyChanges {
                        target: container
                        anchors.topMargin: -d.contentHeight
                    }
                }
            ]
            transitions: [
                Transition {
                    to:"expand"
                    NumberAnimation {
                        properties: "anchors.topMargin"
                        duration: Theme.fastAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                },
                Transition {
                    to:"collapsed"
                    NumberAnimation {
                        properties: "anchors.topMargin"
                        duration: Theme.fastAnimationDuration
                        easing.type: Theme.animationCurve
                    }
                }
            ]
        }
    }
}
