pragma Singleton

import QtQuick
import FluentUI.impl

QtObject {
    readonly property color transparent : "#00000000"
    readonly property color black : "#FF000000"
    readonly property color white : "#FFFFFFFF"
    readonly property color grey : "#FF323130"
    readonly property color grey10 : "#FFFAF9F8"
    readonly property color grey20 : "#FFF3F2F1"
    readonly property color grey30 : "#FFEDEBE9"
    readonly property color grey40 : "#FFE1DFDD"
    readonly property color grey50 : "#FFD2D0CE"
    readonly property color grey60 : "#FFC8C6C4"
    readonly property color grey70 : "#FFBEBBB8"
    readonly property color grey80 : "#FFB3B0AD"
    readonly property color grey90 : "#FFA19F9D"
    readonly property color grey100 : "#FF979593"
    readonly property color grey110 : "#FF8A8886"
    readonly property color grey120 : "#FF797775"
    readonly property color grey130 : "#FF605E5C"
    readonly property color grey140 : "#FF484644"
    readonly property color grey150 : "#FF3B3A39"
    readonly property color grey160 : "#FF323130"
    readonly property color grey170 : "#FF292827"
    readonly property color grey180 : "#FF252423"
    readonly property color grey190 : "#FF201F1E"
    readonly property color grey200 : "#FF1B1A19"
    readonly property color grey210 : "#FF161514"
    readonly property color grey220 : "#FF11100F"
    readonly property color warningPrimaryColor : "#FFD83B01"
    readonly property AccentColor warningSecondaryColor : AccentColor{
        normal: "#FFFFF4CE"
        Component.onCompleted: {
            dark("#FF433519")
        }
    }
    readonly property color errorPrimaryColor : "#FFA80000"
    readonly property AccentColor errorSecondaryColor : AccentColor{
        normal: "#FFfde7e9"
        Component.onCompleted: {
            dark("#FF442726")
        }
    }
    readonly property color successPrimaryColor : "#FF107c10"
    readonly property AccentColor successSecondaryColor : AccentColor{
        normal: "#FFdff6dd"
        Component.onCompleted: {
            dark("#FF393d1b")
        }
    }
    readonly property AccentColor yellow : AccentColor{
        normal: "#ffffeb3b"
        Component.onCompleted: {
            darkest("#fff9a825")
            darker("#fffbc02d")
            dark("#fffdd835")
            light("#ffffee58")
            lighter("#fffff176")
            lightest("#fffff59d")
        }
    }
    readonly property AccentColor orange : AccentColor{
        normal: "#fff7630c"
        Component.onCompleted: {
            darkest("#ff993d07")
            darker("#ffac4508")
            dark("#ffd1540a")
            light("#fff87a30")
            lighter("#fff99154")
            lightest("#fffa9e68")
        }
    }
    readonly property AccentColor red : AccentColor{
        normal: "#ffe81123"
        Component.onCompleted: {
            darkest("#ff8f0a15")
            darker("#ffa20b18")
            dark("#ffb90d1c")
            light("#ffec404f")
            lighter("#ffee5865")
            lightest("#fff06b76")
        }
    }
    readonly property AccentColor magenta : AccentColor{
        normal: "#ffb4009e"
        Component.onCompleted: {
            darkest("#ff6f0061")
            darker("#ff7e006e")
            dark("#ff90007e")
            light("#ffc333b1")
            lighter("#ffca4cbb")
            lightest("#ffd060c2")
        }
    }
    readonly property AccentColor purple : AccentColor{
        normal: "#FF744da9"
        Component.onCompleted: {
            darkest("#ff472f68")
            darker("#ff513576")
            dark("#ff644293")
            light("#ff8664b4")
            lighter("#ff9d82c2")
            lightest("#ffa890c9")
        }
    }
    readonly property AccentColor blue : AccentColor{
        normal: "#ff0078d4"
        Component.onCompleted: {
            darkest("#ff004a83")
            darker("#ff005494")
            dark("#ff0066b4")
            light("#ff268cda")
            lighter("#ff4ca0e0")
            lightest("#ff60abe4")
        }
    }
    readonly property AccentColor teal : AccentColor{
        normal: "#ff00b294"
        Component.onCompleted: {
            darkest("#ff006e5b")
            darker("#ff007c67")
            dark("#ff00977d")
            light("#ff26bda4")
            lighter("#ff4cc9b4")
            lightest("#ff60cfbc")
        }
    }
    readonly property AccentColor green : AccentColor{
        normal: "#ff107c10"
        Component.onCompleted: {
            darkest("#ff094c09")
            darker("#ff0c5d0c")
            dark("#ff0e6f0e")
            light("#ff278927")
            lighter("#ff4b9c4b")
            lightest("#ff6aad6a")
        }
    }
    property var accentColors : [
        yellow,
        orange,
        red,
        magenta,
        purple,
        blue,
        teal,
        green,
    ]
    function calculateLuminance(color) {
        var r = color.r / 1.0
        var g = color.g / 1.0
        var b = color.b / 1.0
        r = r <= 0.03928 ? r / 12.92 : Math.pow((r + 0.055) / 1.055, 2.4)
        g = g <= 0.03928 ? g / 12.92 : Math.pow((g + 0.055) / 1.055, 2.4)
        b = b <= 0.03928 ? b / 12.92 : Math.pow((b + 0.055) / 1.055, 2.4)
        var luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return luminance
    }
    function basedOnLuminance(color,darkColor=Colors.black,lightColor=Colors.white) {
        var luminance = calculateLuminance(color)
        return luminance > 0.435 ? darkColor : lightColor
    }
    function withOpacity(color, opacity) {
        return Tools.withOpacity(color,opacity)
    }

}
