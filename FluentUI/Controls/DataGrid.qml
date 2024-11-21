import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

TreeDataGrid{
    view.addDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.fastAnimationDuration
            easing.type: Theme.animationCurve
        }
    }
    view.move: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.fastAnimationDuration
            easing.type: Theme.animationCurve
        }
    }
    view.moveDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.fastAnimationDuration
            easing.type: Theme.animationCurve
        }
    }
    view.removeDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.fastAnimationDuration
            easing.type: Theme.animationCurve
        }
    }
}
