import QtQuick
import QtQuick.Controls

Loader{
    id: control
    Component.onDestruction: sourceComponent = undefined
}
