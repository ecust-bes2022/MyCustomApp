import QtQuick

QtObject {
    id: control
    property var path
    property var url
    property var argument
    property bool singleton
    property var view
    property var router
    signal activated
    signal deactivated
}
