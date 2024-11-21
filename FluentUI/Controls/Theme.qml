pragma Singleton

import QtQuick
import QtQuick.Controls
import FluentUI.impl

Objects {
    id: control

    property int darkMode: FluentUI.System
    readonly property bool dark: {
        if(darkMode === FluentUI.Light){
            return false
        }else if(darkMode === FluentUI.Dark){
            return true
        }else{
            return R.systemDark
        }
    }
    property int textRender: TextEdit.QtRendering
    property int toolbarDelay: 800
    property int fasterAnimationDuration: 83
    property int fastAnimationDuration: 167
    property int mediumAnimationDuration: 250
    property int slowAnimationDuration: 358
    property int animationCurve: Easing.InOutCubic
    property var primaryColor: Colors.blue
    property var accentColor: ofAccentColor(primaryColor)
    property ColorResource res: dark ? darkResource : lightResource

    property ColorResource darkResource: ColorResource{
        popupBorderColor: "#FF1A1A1A"
        popupBackgroundColor: "#FF2c2c2c"
        micaBackgroundColor: solidBackgroundFillColorBase
        scaffoldBackgroundColor: layerOnAcrylicFillColorDefault
        acrylicBackgroundColor: "#FF2c2c2c"
        inactiveBackgroundColor: "#FF151515"
        textFillColorPrimary: "#FFffffff"
        textFillColorSecondary: "#c5ffffff"
        textFillColorTertiary: "#87ffffff"
        textFillColorDisabled: "#5dffffff"
        textFillColorInverse: "#e4000000"
        accentTextFillColorDisabled: "#5dffffff"
        textOnAccentFillColorSelectedText: "#FFffffff"
        textOnAccentFillColorPrimary: "#FF000000"
        textOnAccentFillColorSecondary: "#80000000"
        textOnAccentFillColorDisabled: "#87ffffff"
        controlFillColorDefault: "#0fffffff"
        controlFillColorSecondary: "#15ffffff"
        controlFillColorTertiary: "#08ffffff"
        controlFillColorDisabled: "#0bffffff"
        controlFillColorTransparent: "#00ffffff"
        controlFillColorInputActive: "#b31e1e1e"
        controlStrongFillColorDefault: "#8bffffff"
        controlStrongFillColorDisabled: "#3fffffff"
        controlSolidFillColorDefault: "#FF454545"
        subtleFillColorTransparent: "#00ffffff"
        subtleFillColorSecondary: "#0fffffff"
        subtleFillColorTertiary: "#0affffff"
        subtleFillColorDisabled: "#00ffffff"
        controlAltFillColorTransparent: "#00ffffff"
        controlAltFillColorSecondary: "#19000000"
        controlAltFillColorTertiary: "#0bffffff"
        controlAltFillColorQuarternary: "#12ffffff"
        controlAltFillColorDisabled: "#00ffffff"
        controlOnImageFillColorDefault: "#b31c1c1c"
        controlOnImageFillColorSecondary: "#FF1a1a1a"
        controlOnImageFillColorTertiary: "#FF131313"
        controlOnImageFillColorDisabled: "#FF1e1e1e"
        accentFillColorDisabled: "#28ffffff"
        controlStrokeColorDefault: "#12ffffff"
        controlStrokeColorSecondary: "#18ffffff"
        controlStrokeColorOnAccentDefault: "#14ffffff"
        controlStrokeColorOnAccentSecondary: "#23000000"
        controlStrokeColorOnAccentTertiary: "#37000000"
        controlStrokeColorOnAccentDisabled: "#33000000"
        controlStrokeColorForStrongFillWhenOnImage: "#6b000000"
        cardStrokeColorDefault: "#19000000"
        cardStrokeColorDefaultSolid: "#FF1c1c1c"
        controlStrongStrokeColorDefault: "#8bffffff"
        controlStrongStrokeColorDisabled: "#28ffffff"
        surfaceStrokeColorDefault: "#66757575"
        surfaceStrokeColorFlyout: "#33000000"
        surfaceStrokeColorInverse: "#0f000000"
        dividerStrokeColorDefault: "#15ffffff"
        focusStrokeColorOuter: "#FFffffff"
        focusStrokeColorInner: "#b3000000"
        cardBackgroundFillColorDefault: "#0dffffff"
        cardBackgroundFillColorSecondary: "#08ffffff"
        smokeFillColorDefault: "#4d000000"
        layerFillColorDefault: "#4c3a3a3a"
        layerFillColorAlt: "#0dffffff"
        layerOnAcrylicFillColorDefault: "#09ffffff"
        layerOnAccentAcrylicFillColorDefault: "#09ffffff"
        layerOnMicaBaseAltFillColorDefault: "#733a3a3a"
        layerOnMicaBaseAltFillColorSecondary: "#0fffffff"
        layerOnMicaBaseAltFillColorTertiary: "#FF2c2c2c"
        layerOnMicaBaseAltFillColorTransparent: "#00ffffff"
        solidBackgroundFillColorBase: "#FF202020"
        solidBackgroundFillColorSecondary: "#FF1c1c1c"
        solidBackgroundFillColorTertiary: "#FF282828"
        solidBackgroundFillColorQuarternary: "#FF2c2c2c"
        solidBackgroundFillColorTransparent: "#00202020"
        solidBackgroundFillColorBaseAlt: "#FF0a0a0a"
        systemFillColorSuccess: "#FF6ccb5f"
        systemFillColorCaution: "#FFfce100"
        systemFillColorCritical: "#FFff99a4"
        systemFillColorNeutral: "#8bffffff"
        systemFillColorSolidNeutral: "#FF9d9d9d"
        systemFillColorAttentionBackground: "#08ffffff"
        systemFillColorSuccessBackground: "#FF393d1b"
        systemFillColorCautionBackground: "#FF433519"
        systemFillColorCriticalBackground: "#FF442726"
        systemFillColorNeutralBackground: "#08ffffff"
        systemFillColorSolidAttentionBackground: "#FF2e2e2e"
        systemFillColorSolidNeutralBackground: "#FF2e2e2e"
    }

    property ColorResource lightResource: ColorResource{
        popupBorderColor: "#FFD2D2D2"
        popupBackgroundColor: "#FFf9f9f9"
        micaBackgroundColor: solidBackgroundFillColorBase
        scaffoldBackgroundColor: layerOnAcrylicFillColorDefault
        acrylicBackgroundColor: layerOnAcrylicFillColorDefault
        inactiveBackgroundColor: "#FFd6d6d6"
        textFillColorPrimary: "#e4000000"
        textFillColorSecondary: "#9e000000"
        textFillColorTertiary: "#72000000"
        textFillColorDisabled: "#5c000000"
        textFillColorInverse: "#FFffffff"
        accentTextFillColorDisabled: "#5c000000"
        textOnAccentFillColorSelectedText: "#FFffffff"
        textOnAccentFillColorPrimary: "#FFffffff"
        textOnAccentFillColorSecondary: "#b3ffffff"
        textOnAccentFillColorDisabled: "#FFffffff"
        controlFillColorDefault: "#b3ffffff"
        controlFillColorSecondary: "#80f9f9f9"
        controlFillColorTertiary: "#4df9f9f9"
        controlFillColorDisabled: "#4df9f9f9"
        controlFillColorTransparent: "#00ffffff"
        controlFillColorInputActive: "#FFffffff"
        controlStrongFillColorDefault: "#72000000"
        controlStrongFillColorDisabled: "#51000000"
        controlSolidFillColorDefault: "#FFffffff"
        subtleFillColorTransparent: "#00ffffff"
        subtleFillColorSecondary: "#09000000"
        subtleFillColorTertiary: "#06000000"
        subtleFillColorDisabled: "#00ffffff"
        controlAltFillColorTransparent: "#00ffffff"
        controlAltFillColorSecondary: "#06000000"
        controlAltFillColorTertiary: "#0f000000"
        controlAltFillColorQuarternary: "#18000000"
        controlAltFillColorDisabled: "#00ffffff"
        controlOnImageFillColorDefault: "#c9ffffff"
        controlOnImageFillColorSecondary: "#FFf3f3f3"
        controlOnImageFillColorTertiary: "#FFebebeb"
        controlOnImageFillColorDisabled: "#00ffffff"
        accentFillColorDisabled: "#37000000"
        controlStrokeColorDefault: "#0f000000"
        controlStrokeColorSecondary: "#29000000"
        controlStrokeColorOnAccentDefault: "#14ffffff"
        controlStrokeColorOnAccentSecondary: "#66000000"
        controlStrokeColorOnAccentTertiary: "#37000000"
        controlStrokeColorOnAccentDisabled: "#0f000000"
        controlStrokeColorForStrongFillWhenOnImage: "#59ffffff"
        cardStrokeColorDefault: "#0f000000"
        cardStrokeColorDefaultSolid: "#FFebebeb"
        controlStrongStrokeColorDefault: "#72000000"
        controlStrongStrokeColorDisabled: "#37000000"
        surfaceStrokeColorDefault: "#66757575"
        surfaceStrokeColorFlyout: "#0f000000"
        surfaceStrokeColorInverse: "#15ffffff"
        dividerStrokeColorDefault: "#0f000000"
        focusStrokeColorOuter: "#e4000000"
        focusStrokeColorInner: "#b3ffffff"
        cardBackgroundFillColorDefault: "#b3ffffff"
        cardBackgroundFillColorSecondary: "#80f6f6f6"
        smokeFillColorDefault: "#4d000000"
        layerFillColorDefault: "#80ffffff"
        layerFillColorAlt: "#FFffffff"
        layerOnAcrylicFillColorDefault: "#40ffffff"
        layerOnAccentAcrylicFillColorDefault: "#40ffffff"
        layerOnMicaBaseAltFillColorDefault: "#b3ffffff"
        layerOnMicaBaseAltFillColorSecondary: "#0a000000"
        layerOnMicaBaseAltFillColorTertiary: "#FFf9f9f9"
        layerOnMicaBaseAltFillColorTransparent: "#00000000"
        solidBackgroundFillColorBase: "#FFf3f3f3"
        solidBackgroundFillColorSecondary: "#FFeeeeee"
        solidBackgroundFillColorTertiary: "#FFf9f9f9"
        solidBackgroundFillColorQuarternary: "#FFffffff"
        solidBackgroundFillColorTransparent: "#00f3f3f3"
        solidBackgroundFillColorBaseAlt: "#FFdadada"
        systemFillColorSuccess: "#FF0f7b0f"
        systemFillColorCaution: "#FF9d5d00"
        systemFillColorCritical: "#FFc42b1c"
        systemFillColorNeutral: "#72000000"
        systemFillColorSolidNeutral: "#FF8a8a8a"
        systemFillColorAttentionBackground: "#80f6f6f6"
        systemFillColorSuccessBackground: "#FFdff6dd"
        systemFillColorCautionBackground: "#FFfff4ce"
        systemFillColorCriticalBackground: "#FFfde7e9"
        systemFillColorNeutralBackground: "#06000000"
        systemFillColorSolidAttentionBackground: "#FFf7f7f7"
        systemFillColorSolidNeutralBackground: "#FFf3f3f3"
    }

    function buttonColor(button,transparentWhenNone = false,isDark = null){
        if(isDark === null){
            isDark = Theme.dark
        }
        var res = ofDark(isDark)
        if(!button.enabled){
            return res.controlFillColorDisabled
        }
        if(button.pressed){
            return res.controlFillColorTertiary
        }
        if(button.hovered){
            return res.controlFillColorSecondary
        }
        return transparentWhenNone ? res.subtleFillColorTransparent : res.controlFillColorDefault
    }

    function uncheckedInputColor(button,transparentWhenNone = false,transparentWhenDisabled = false,isDark = null){
        if(isDark === null){
            isDark = Theme.dark
        }
        var res = ofDark(isDark)
        if(!button.enabled){
            if(transparentWhenDisabled){
                return res.subtleFillColorTransparent
            }
            return res.controlAltFillColorDisabled
        }
        if(button.pressed){
            return res.subtleFillColorTertiary
        }
        if(button.hovered){
            return res.subtleFillColorSecondary
        }
        return transparentWhenNone ? res.subtleFillColorTransparent : res.controlAltFillColorSecondary
    }

    function checkedInputColor(button,accentColor,isDark = null){
        if(isDark === null){
            isDark = Theme.dark
        }
        var res = ofDark(isDark)
        if(!button.enabled){
            return res.accentFillColorDisabled
        }
        if(button.pressed){
            return accentColor.tertiaryBrushFor(isDark)
        }
        if(button.hovered){
            return accentColor.secondaryBrushFor(isDark)
        }
        return accentColor.defaultBrushFor(isDark)
    }

    function of(control){
        var accent = ofAccentColor(control.FluentUI.primaryColor)
        return {res:ofDark(control.FluentUI.dark),accentColor: accent}
    }

    function ofAccentColor(color){
        var accent
        var primaryColor
        if(color){
            primaryColor = color
        }else{
            primaryColor = Theme.primaryColor
        }
        if(primaryColor instanceof AccentColor){
            accent = color
        }else{
            var primaryColorStr = String(primaryColor)
            switch(primaryColorStr){
            case "Colors.yellow":
                accent = Colors.yellow
                break
            case "Colors.orange":
                accent = Colors.orange
                break
            case "Colors.red":
                accent = Colors.red
                break
            case "Colors.magenta":
                accent = Colors.magenta
                break
            case "Colors.purple":
                accent = Colors.purple
                break
            case "Colors.blue":
                accent = Colors.blue
                break
            case "Colors.teal":
                accent = Colors.teal
                break
            case "Colors.green":
                accent = Colors.green
                break
            default:
                accent = accent_color.createObject(control,{normal:primaryColorStr})
                break
            }
        }
        return accent
    }

    function ofDark(isDark):ColorResource{
        return isDark ? darkResource : lightResource
    }

    Component{
        id: accent_color
        AccentColor{}
    }

}
