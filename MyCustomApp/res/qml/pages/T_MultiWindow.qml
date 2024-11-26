import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ScrollablePage {

    title: qsTr("MultiWindow")
    columnSpacing: 24
    property string password: ""

    WindowResultLauncher{
        id: loginResultLauncher
        path: "/login"
        onResult:
            (data)=>{
                password = data.password
            }
    }

    GroupBox{
        title: "Standard Window"
        Layout.fillWidth: true
        Layout.preferredHeight: 120
        Column{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Label{
                text: qsTr("<font color='red'>Standard</font> mode window，a new window is created every time")
            }
            Button{
                property int count: 0
                text: qsTr("Open Window")
                onClicked: {
                    count++
                    WindowRouter.go("/standardwindow",{type:"WindowType.Standard",count:count})
                }
            }
        }
    }


    GroupBox{
        title: "SingleTask Window"
        Layout.fillWidth: true
        Layout.preferredHeight: 120
        Column{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Label{
                text: qsTr("<font color='red'>SingleTask</font> mode window，If the window exists, destroy the window and create a new window")
            }
            Button{
                property int count: 0
                text: qsTr("Open Window")
                onClicked: {
                    count++
                    WindowRouter.go("/singletaskwindow",{type:"WindowType.SingleTask",count:count})
                }
            }
        }
    }

    GroupBox{
        title: "SingleInstance Window"
        Layout.fillWidth: true
        Layout.preferredHeight: 120
        Column{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Label{
                text: qsTr("<font color='red'>SingleInstance</font> mode window，If a window exists, this activates the window")
            }
            Button{
                property int count: 0
                text: qsTr("Open Window")
                onClicked: {
                    count++
                    WindowRouter.go("/singleinstancewindow",{type:"WindowType.SingleInstance",count:count})
                }
            }
        }
    }

    GroupBox{
        title: "WindowResultLauncher"
        Layout.fillWidth: true
        Layout.preferredHeight: 150
        Column{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Label{
                text: qsTr("Create a window with the parameter username: zhuzichu520@outlook.com")
            }
            Button{
                text: qsTr("Open Window")
                onClicked: {
                    loginResultLauncher.launch({username:"zhuzichu520@outlook.com"})
                }
            }
            Label{
                text:qsTr("Login Window Returned Password - >")+password
            }
        }
    }

}
