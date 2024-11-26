import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("SubPage")
    header: Item{}

    Button{
        Layout.preferredHeight: 68
        Layout.fillWidth: true
        Label{
            text: qsTr("This is a subpage of StackPage")
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
        }
        Icon{
            source: FluentIcons.graph_ChevronRight
            width: 20
            height: 20
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 20
            }
        }
        onClicked: {
            pageRouter.go("/subpage")
        }
    }

}
