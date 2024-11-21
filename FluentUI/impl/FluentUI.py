import os
from enum import IntFlag

from PySide6.QtCore import QFlag, Signal, Property, QByteArray, QFile, QSettings
from PySide6.QtGui import QColor
from PySide6.QtQml import QmlAttached, QmlElement, QJSValue, QmlUncreatable
from PySide6.QtQuickControls2 import QQuickAttachedPropertyPropagator

QML_IMPORT_NAME = "FluentUI.Controls"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0


class GlobalConfig:
    def __init__(self):
        self.radius = 4
        self.highlightMoveDuration = 167
        self.primaryColor = "Colors.blue"
        self.textColor = QColor(255, 255, 255, 255)
        self.minimumHeight = 400
        self.dark = False


FluentUI_config = None


def resolveSetting(env, settings, name):
    value = QByteArray(os.getenv(env))
    if not value and settings:
        value = QByteArray(settings.value(name))
    return value


def getSettings(group):
    file_path = os.getenv("QT_QUICK_CONTROLS_CONF")
    if file_path and QFile.exists(file_path):
        settings = QSettings(file_path, QSettings.Format.IniFormat)
        if group:
            settings.beginGroup(group)
        return settings
    return None


def initGlobalConfig():
    global FluentUI_config
    FluentUI_config = GlobalConfig()
    settings = getSettings("FluentUI")
    radius_value = resolveSetting("QT_QUICK_CONTROLS_FLUENTUI_RADIUS", settings, "Radius")
    if radius_value:
        FluentUI_config.radius = int(radius_value.toStdString())
    primary_color_value = resolveSetting("QT_QUICK_CONTROLS_FLUENTUI_PRIMARYCOLOR", settings, "PrimaryColor")
    if primary_color_value:
        FluentUI_config.primaryColor = primary_color_value.toStdString()
    highlight_move_value = resolveSetting("QT_QUICK_CONTROLS_FLUENTUI_HIGHLIGHTMOVE", settings, "HighlightMove")
    if highlight_move_value:
        FluentUI_config.highlightMoveDuration = int(highlight_move_value.toStdString())
    min_height_value = resolveSetting("QT_QUICK_CONTROLS_FLUENTUI_MINIMUMHEIGHT", settings, "MinimumHeight")
    if min_height_value:
        FluentUI_config.minimumHeight = int(min_height_value.toStdString())


@QmlAttached(QQuickAttachedPropertyPropagator)
@QmlUncreatable("")
class FluentStyleAttached(QQuickAttachedPropertyPropagator):
    textColorChanged = Signal()
    highlightMoveDurationChanged = Signal()
    radiusChanged = Signal()
    minimumHeightChanged = Signal()
    primaryColorChanged = Signal()
    themeChanged = Signal()
    darkChanged = Signal()

    @staticmethod
    def qmlAttachedProperties(self, o):
        global FluentUI_config
        if FluentUI_config is None:
            initGlobalConfig()
        return FluentStyleAttached(FluentUI_config, o)

    def __init__(self, config: GlobalConfig, parent=None):
        super().__init__(parent)
        self.__config = config
        self.__radius = config.radius
        self.__highlightMoveDuration = config.highlightMoveDuration
        self.__minimumHeight = config.minimumHeight
        self.__textColor = config.textColor
        self.__primaryColor = config.primaryColor
        self.__explicitPrimaryColor = False
        self.__dark = config.dark
        self.__explicitDark = False
        self.__theme = None

    def attachedParentChange(self, newParent, oldParent):
        attached = newParent if isinstance(newParent, FluentStyleAttached) else None
        if attached:
            self.inheritDark(attached.dark)
            self.inheritPrimaryColor(attached.primaryColor)

    def getDark(self):
        return self.__dark

    def setDark(self, value):
        self.__explicitDark = True
        if self.__dark == value:
            return
        self.__dark = value
        self.propagateDark()
        self.darkChanged.emit()

    def resetDark(self):
        if not self.__explicitDark:
            return
        self.__explicitDark = False
        attached = self.attachedParent()
        if isinstance(attached, FluentStyleAttached):
            self.inheritDark(attached.dark)
        else:
            self.inheritDark(self.__config.dark)

    def inheritDark(self, dark):
        if self.__explicitDark or self.__dark == dark:
            return
        self.__dark = dark
        self.propagateDark()
        self.darkChanged.emit()

    def propagateDark(self):
        styles = self.attachedChildren()
        for child in styles:
            attached = child if isinstance(child, FluentStyleAttached) else None
            if attached:
                attached.inheritDark(self.__dark)

    dark = Property(bool, getDark, setDark, resetDark, notify=darkChanged, final=True)

    def getPrimaryColor(self):
        return self.__primaryColor

    def setPrimaryColor(self, value):
        self.__explicitPrimaryColor = True
        if self.__primaryColor == value:
            return
        self.__primaryColor = value
        self.propagatePrimaryColor()
        self.primaryColorChanged.emit()

    def resetPrimaryColor(self):
        if not self.__explicitPrimaryColor:
            return
        self.__explicitPrimaryColor = False
        attached = self.attachedParent()
        if isinstance(attached, FluentStyleAttached):
            self.inheritPrimaryColor(attached.primaryColor)
        else:
            self.inheritPrimaryColor(self.__config.primaryColor)

    def inheritPrimaryColor(self, primaryColor):
        if self.__explicitPrimaryColor or self.__primaryColor == primaryColor:
            return
        self.__primaryColor = primaryColor
        self.propagatePrimaryColor()
        self.primaryColorChanged.emit()

    def propagatePrimaryColor(self):
        styles = self.attachedChildren()
        for child in styles:
            attached = child if isinstance(child, FluentStyleAttached) else None
            if attached:
                attached.inheritPrimaryColor(self.__primaryColor)

    primaryColor = Property(QJSValue, getPrimaryColor, setPrimaryColor, resetPrimaryColor, notify=primaryColorChanged,
                            final=True)

    @Property(QJSValue, notify=themeChanged)
    def theme(self):
        return self.__theme

    @theme.setter
    def theme(self, value):
        if self.__theme == value:
            return
        self.__theme = value
        self.themeChanged.emit()

    @Property(int, notify=minimumHeightChanged)
    def minimumHeight(self):
        return self.__minimumHeight

    @minimumHeight.setter
    def minimumHeight(self, value):
        if self.__minimumHeight == value:
            return
        self.__minimumHeight = value
        self.minimumHeightChanged.emit()

    @Property(int, notify=radiusChanged)
    def radius(self):
        return self.__radius

    @radius.setter
    def radius(self, value):
        if self.__radius == value:
            return
        self.__radius = value
        self.radiusChanged.emit()

    @Property(int, notify=highlightMoveDurationChanged)
    def highlightMoveDuration(self):
        return self.__highlightMoveDuration

    @highlightMoveDuration.setter
    def highlightMoveDuration(self, value):
        if self.__highlightMoveDuration == value:
            return
        self.__highlightMoveDuration = value
        self.highlightMoveDurationChanged.emit()

    @Property(QColor, notify=textColorChanged)
    def textColor(self):
        return self.__textColor

    @textColor.setter
    def textColor(self, value):
        if self.__textColor == value:
            return
        self.__textColor = value
        self.textColorChanged.emit()


@QmlElement
@QmlAttached(FluentStyleAttached)
@QmlUncreatable("")
class FluentUI(FluentStyleAttached):
    class DarkMode(IntFlag):
        Light = 0x0000
        Dark = 0x0001
        System = 0x0002

    QFlag(DarkMode)

    def __init__(self, config: GlobalConfig, parent=None):
        super().__init__(config, parent)

    @staticmethod
    def qmlAttachedProperties(self, o):
        global FluentUI_config
        if FluentUI_config is None:
            initGlobalConfig()
        return FluentUI(FluentUI_config, o)
