import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    id: page

    title: qsTr("ContentDialog")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls

Item{
    id: root
    width: parent.width
    height: layout_content.height
    Column{
        id: layout_content
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 30
        spacing: 20
        Label {
            width: parent.width
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            text: qsTr("Dialog is a popup that is mostly used for short-term tasks "
                + "and brief communications with the user.")
        }
        Button {
            text: qsTr("Message")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: messageDialog.open()
            width: 120
            Dialog {
                id: messageDialog
                x: Math.ceil((parent.width - width) / 2)
                y: Math.ceil((parent.height - height) / 2)
                title: qsTr("Message")
                Label {
                    text: qsTr("Lorem ipsum dolor sit amet...")
                }
            }
        }
        Button {
            id: button
            text: qsTr("Confirmation")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: confirmationDialog.open()
            width: 120
            Dialog {
                id: confirmationDialog
                x: Math.ceil((parent.width - width) / 2)
                y: Math.ceil((parent.height - height) / 2)
                parent: Overlay.overlay
                modal: true
                title: qsTr("Confirmation")
                standardButtons: Dialog.Yes | Dialog.No
                Column {
                    spacing: 20
                    anchors.fill: parent
                    Label {
                        text: qsTr("The document has been modified.\nDo you want to save your changes?")
                    }
                    CheckBox {
                        text: qsTr("Do not ask again")
                        anchors.right: parent.right
                    }
                }
            }
        }
        Button {
            text: qsTr("Content")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: contentDialog.open()
            width: 120
            Dialog {
                id: contentDialog
                x: Math.ceil((parent.width - width) / 2)
                y: Math.ceil((parent.height - height) / 2)
                width: Math.ceil(parent.width / 3)
                contentHeight: 400
                parent: Overlay.overlay
                modal: true
                title: qsTr("Content")
                standardButtons: Dialog.Close
                Flickable {
                    id: flickable
                    clip: true
                    anchors.fill: parent
                    contentHeight: column.height
                    Column {
                        id: column
                        spacing: 20
                        width: parent.width
                        Image {
                            id: logo
                            width: parent.width / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/qt/qml/Gallery/res/image/logo.png"
                        }
                        Label {
                            width: parent.width
                            text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc finibus "
                                + "in est quis laoreet. Interdum et malesuada fames ac ante ipsum primis "
                                + "in faucibus. Curabitur eget justo sollicitudin enim faucibus bibendum. "
                                + "Suspendisse potenti. Vestibulum cursus consequat mauris id sollicitudin. "
                                + "Duis facilisis hendrerit consectetur. Curabitur sapien tortor, efficitur "
                                + "id auctor nec, efficitur et nisl. Ut venenatis eros in nunc placerat, "
                                + "eu aliquam enim suscipit.")
                            wrapMode: Label.Wrap
                        }
                    }
                    ScrollIndicator.vertical: ScrollIndicator {
                        parent: contentDialog.contentItem
                        anchors.top: flickable.top
                        anchors.bottom: flickable.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: -contentDialog.rightPadding + 1
                    }
                }
            }
        }
        Button {
            text: qsTr("Input")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: inputDialog.open()
            width: 120
            Dialog {
                id: inputDialog
                x: Math.ceil((parent.width - width) / 2)
                y: Math.ceil((parent.height - height) / 2)
                parent: Overlay.overlay
                focus: true
                modal: true
                title: qsTr("Input")
                standardButtons: Dialog.Ok | Dialog.Cancel
                ColumnLayout {
                    spacing: 20
                    anchors.fill: parent
                    Label {
                        elide: Label.ElideRight
                        text: qsTr("Please enter the credentials:")
                        Layout.fillWidth: true
                    }
                    TextField {
                        focus: true
                        placeholderText: qsTr("Username")
                        Layout.fillWidth: true
                    }
                    TextField {
                        placeholderText: qsTr("Password")
                        echoMode: TextField.PasswordEchoOnEdit
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
`}

}
