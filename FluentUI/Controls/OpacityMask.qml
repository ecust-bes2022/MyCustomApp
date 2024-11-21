import QtQuick

Item {
    id: control
    property variant source
    property variant maskSource
    property bool cached: false
    property bool invert: false
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
        property variant maskSource: control.maskSource
        anchors.fill: parent
        fragmentShader: invert ? "qrc:/qt/qml/FluentUI/Controls/shaders/opacitymask_invert.frag.qsb" : "qrc:/qt/qml/FluentUI/Controls/shaders/opacitymask.frag.qsb"
    }
}
