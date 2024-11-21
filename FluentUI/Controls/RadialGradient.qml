import QtQuick

Item {
    id: control
    property bool cached: false
    property real horizontalOffset: 0.0
    property real verticalOffset: 0.0
    property real horizontalRadius: width
    property real verticalRadius: height
    property real angle: 0.0
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
        property variant gradientImage: gradientSource
        property variant maskSource: control.source
        property variant center: Qt.point(0.5 + control.horizontalOffset / width, 0.5 + control.verticalOffset / height)
        property real horizontalRatio: control.horizontalRadius > 0 ? width / (2 * control.horizontalRadius) : width * 16384
        property real verticalRatio: control.verticalRadius > 0 ? height / (2 * control.verticalRadius) : height * 16384
        property real angle: -control.angle / 360 * 2 * Math.PI
        property variant matrixData: Qt.point(Math.sin(angle), Math.cos(angle))
        anchors.fill: parent
        vertexShader: "qrc:/qt/qml/FluentUI/Controls/shaders/radialgradient.vert.qsb"
        fragmentShader: maskSource === undefined ? noMaskShader : maskShader
        onFragmentShaderChanged: horizontalRatioChanged()
        property string maskShader: "qrc:/qt/qml/FluentUI/Controls/shaders/radialgradient_mask.frag.qsb"
        property string noMaskShader: "qrc:/qt/qml/FluentUI/Controls/shaders/radialgradient_nomask.frag.qsb"
    }
}
