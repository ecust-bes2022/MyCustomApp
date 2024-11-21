import QtQuick

Item {
    id: control
    property variant source
    property color color: "transparent"
    property bool cached: false
    ShaderEffectSource {
        id: cacheItem
        anchors.fill: parent
        visible: control.cached
        smooth: true
        sourceItem: shaderItem
        live: true
        hideSource: visible
    }
    ShaderEffect {
        id: shaderItem
        property variant source: control.source
        property color color: control.color
        anchors.fill: parent
        fragmentShader: "qrc:/qt/qml/FluentUI/Controls/shaders/coloroverlay.frag.qsb"
    }
}
