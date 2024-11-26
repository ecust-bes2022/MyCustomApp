import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Marquee")
    columnSpacing: 24

    CardHighlight{
        Layout.fillWidth: true
        showDisabled: false
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls

ColumnLayout{
    Marquee {
        implicitWidth: 450
        implicitHeight: 40
        model: [qsTr("Tell me a fun fact about the Roman Empire"),qsTr("Improve my essay writing ask me to outline my thoughts"),qsTr("Create a morning routine to boost my productivity")]
        speedFactor: 10
    }
    Marquee {
        implicitWidth: 450
        implicitHeight: 40
        layoutDirection: Qt.RightToLeft
        model: [qsTr("Tell me a fun fact about the Roman Empire"),qsTr("Improve my essay writing ask me to outline my thoughts"),qsTr("Create a morning routine to boost my productivity")]
        speedFactor: 10
    }
    Marquee {
        implicitWidth: 450
        implicitHeight: 40
        layoutDirection: Qt.RightToLeft
        model: [{title:qsTr("Give me ideas about how to plan my New Years resolutions"),color:Colors.blue.normal},{title:qsTr("Help me pick an outfit that will look good on camera"),color:Colors.teal.normal},{title:qsTr("Design a programming game teach basics in a fun way"),color:Colors.red.normal}]
        speedFactor: 15
        delegate: Label {
            font: Typography.title
            text: modelData.title
            color: modelData.color
        }
    }
    Marquee {
        implicitWidth: 450
        implicitHeight: 40
        model: [{title:qsTr("Give me ideas about how to plan my New Years resolutions"),color:Colors.blue.normal},{title:qsTr("Help me pick an outfit that will look good on camera"),color:Colors.teal.normal},{title:qsTr("Design a programming game teach basics in a fun way"),color:Colors.red.normal}]
        speedFactor: 15
        delegate: Label {
            font: Typography.title
            text: modelData.title
            color: modelData.color
        }
    }
    Marquee {
        implicitWidth: 240
        implicitHeight: 120
        Layout.leftMargin: 105
        model: [{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_1.svg"},{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_2.svg"},{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_3.svg"}]
        speedFactor: 20
        delegate: Image{
            id: iamge_avatar_1
            width: 120
            height: 120
            source: modelData.avatar
            SequentialAnimation{
                running: true
                loops: Animation.Infinite
                PropertyAnimation {
                    target: iamge_avatar_1
                    from: 0.9
                    to: 1.1
                    property: "scale"
                    duration: Theme.fastAnimationDuration
                }
                PropertyAnimation {
                    target: iamge_avatar_1
                    from: 1.1
                    to: 0.9
                    property: "scale"
                    duration: Theme.fastAnimationDuration
                }
            }
        }
    }
    Marquee {
        implicitWidth: 240
        implicitHeight: 120
        Layout.leftMargin: 105
        layoutDirection: Qt.RightToLeft
        model: [{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_4.svg"},{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_5.svg"},{avatar:"qrc:/qt/qml/Gallery/res/image/avatar_6.svg"}]
        speedFactor: 20
        delegate: Image{
            id: iamge_avatar_2
            width: 120
            height: 120
            source: modelData.avatar
            SequentialAnimation{
                running: true
                loops: Animation.Infinite
                ScaleAnimator {
                    target: iamge_avatar_2
                    from: 0.9
                    to: 1.1
                    duration: Theme.fastAnimationDuration
                }
                ScaleAnimator {
                    target: iamge_avatar_2
                    from: 1.1
                    to: 0.9
                    duration: Theme.fastAnimationDuration
                }
            }
        }
    }
}
`}
}
