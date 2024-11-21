import QtQuick

Item {
    id: control
    property variant start: Qt.point(0, 0)
    property variant end: Qt.point(0, height)
    property bool cached: false
    property variant source
    property Gradient gradient: Gradient {
        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 1.0; color: "black" }
    }
    ShaderEffectSource {
        id: gradientSource
        sourceItem: Rectangle {
            width: 16
            height: 256
            gradient: control.gradient
            smooth: true
        }
        smooth: true
        hideSource: true
        visible: false
    }
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
        anchors.fill: parent
        property variant source: gradientSource
        property variant maskSource: control.source
        property variant startPoint: Qt.point(start.x / width, start.y / height)
        property real dx: end.x - start.x
        property real dy: end.y - start.y
        property real l: 1.0 / Math.sqrt(Math.pow(dx / width, 2.0) + Math.pow(dy / height, 2.0))
        property real angle: Math.atan2(dx, dy)
        property variant matrixData: Qt.point(Math.sin(angle), Math.cos(angle))
        vertexShader: "qrc:/qt/qml/FluentUI/Controls/shaders/lineargradient.vert.qsb"
        fragmentShader: maskSource === undefined ? noMaskShader : maskShader
        onFragmentShaderChanged: lChanged()
        property string maskShader: "qrc:/qt/qml/FluentUI/Controls/shaders/lineargradient_mask.frag.qsb"
        property string noMaskShader: "qrc:/qt/qml/FluentUI/Controls/shaders/lineargradient_nomask.frag.qsb"
    }
}
