import sys
from PySide6.QtCore import QObject, Slot, Qt, QSettings, Signal, Property, QEvent, QUrl
from PySide6.QtGui import QGuiApplication, QColor, QCursor, QPalette, QImage
from PySide6.QtQml import QmlSingleton, QmlNamedElement, qmlEngine, qmlContext


def getSystemDark():
    palette = QGuiApplication.palette()
    color = palette.color(QPalette.ColorRole.Window)
    luminance = color.red() * 0.2126 + color.green() * 0.7152 + color.blue() * 0.0722
    return luminance <= 255 / 2


QML_IMPORT_NAME = "FluentUI.impl"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0


@QmlNamedElement("R")
@QmlSingleton
class __R(QObject):
    systemDarkChanged = Signal()
    windowIconChanged = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.__systemDark = getSystemDark()
        self.__windowIcon = QUrl()
        self.__engine = None
        self.__baseUrl = ""
        QGuiApplication.instance().installEventFilter(self)

    def init(self, val: QObject):
        self.__engine = qmlEngine(val)
        self.__baseUrl = self.__engine.baseUrl().toString()

    @Slot(str, result=str)
    def resolvedUrl(self, val: str):
        if self.__engine is None:
            return val
        return self.__baseUrl + val

    @staticmethod
    def create(_):
        return R()

    def eventFilter(self, watched, event):
        if event.type() == QEvent.Type.ApplicationPaletteChange or event.type() == QEvent.Type.ThemeChange:
            dark = getSystemDark()
            if self.__systemDark != dark:
                self.__systemDark = dark
                self.systemDarkChanged.emit()
                event.accept()
            return True
        return False

    @Property(QUrl, notify=windowIconChanged)
    def windowIcon(self):
        return self.__windowIcon

    @windowIcon.setter
    def windowIcon(self, value):
        if self.__windowIcon == value:
            return
        self.__windowIcon = value
        self.windowIconChanged.emit()

    @Property(bool, notify=systemDarkChanged)
    def systemDark(self):
        return self.__systemDark


__r = None


def R() -> __R:
    global __r
    if __r is None:
        __r = __R()
    return __r
