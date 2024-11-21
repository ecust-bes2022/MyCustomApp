import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

FramelessWindow {
    id: window
    width: 640
    height: 480
    minimumWidth: 320
    minimumHeight: 240
    visible: true
    launchMode: WindowType.SingleInstance
    initialItem: R.resolvedUrl("MainScreen.qml")
}
