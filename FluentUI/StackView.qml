import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import FluentUI.Controls

T.StackView {
    id: control
    component LineAnimation: NumberAnimation {
        duration: Theme.fastAnimationDuration
        easing.type: Theme.animationCurve
    }
    component FadeIn: LineAnimation {
        property: "opacity"
        from: 0.0
        to: 1.0
    }
    component FadeOut: LineAnimation {
        property: "opacity"
        from: 1.0
        to: 0.0
    }
    popEnter: Transition {
        LineAnimation { property: "y"; from: (control.mirrored ? -0.5 : 0.5) *  -control.height; to: 0 }
        FadeIn {}
    }
    popExit: Transition {
        LineAnimation { property: "y"; from: 0; to: (control.mirrored ? -0.5 : 0.5) * control.height }
        FadeOut {}
    }
    pushEnter: Transition {
        LineAnimation { property: "y"; from: (control.mirrored ? -0.5 : 0.5) * control.height; to: 0 }
        FadeIn {}
    }
    pushExit: Transition {
        LineAnimation { property: "y"; from: 0; to: (control.mirrored ? -0.5 : 0.5) * -control.height }
        FadeOut {}
    }
    replaceEnter: Transition {
        LineAnimation { property: "y"; from: (control.mirrored ? -0.5 : 0.5) * control.height; to: 0 }
        FadeIn {}
    }
    replaceExit: Transition {
        LineAnimation { property: "y"; from: 0; to: (control.mirrored ? -0.5 : 0.5) * -control.height }
        FadeOut {}
    }
}
