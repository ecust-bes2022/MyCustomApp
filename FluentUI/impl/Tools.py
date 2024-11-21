import sys
from PySide6.QtCore import QObject, Slot, Qt, QSettings, Signal, Property, QEvent, QUrl
from PySide6.QtGui import QGuiApplication, QColor, QCursor, QPalette, QImage
from PySide6.QtQml import QmlSingleton, QmlNamedElement


def windowBuildNumber() -> int:
    if sys.platform.startswith("win"):
        regKey = QSettings("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
                           QSettings.Format.NativeFormat)
        if regKey.contains("CurrentBuildNumber"):
            buildNumber = int(str(regKey.value("CurrentBuildNumber")))
            return buildNumber
    return -1


QML_IMPORT_NAME = "FluentUI.impl"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0


@QmlNamedElement("Tools")
@QmlSingleton
class __Tools(QObject):

    def __init__(self, parent=None):
        super().__init__(parent)

    @staticmethod
    def create(_):
        return Tools()

    @Slot(str, result=bool)
    def isUrl(self, val: str):
        url = QUrl(val)
        return url.isValid() and not url.scheme() == ""

    @Slot(result=int)
    def cursorScreenIndex(self):
        screen_index = 0
        screens = QGuiApplication.screens()
        screen_count = len(screens)
        if screen_count > 1:
            pos = QCursor.pos()
            for i in range(screen_count):
                if screens[i].geometry().contains(pos):
                    screen_index = i
                    break
        return screen_index

    @Slot(result=QImage)
    def captureDesktop(self):
        screen = QGuiApplication.screens()[self.cursorScreenIndex()]
        if screen:
            return screen.grabWindow(0).toImage()
        return QImage()

    @Slot(str)
    def clipText(self, val: str):
        QGuiApplication.clipboard().setText(val)

    @Slot(int)
    def setOverrideCursor(self, val):
        QGuiApplication.setOverrideCursor(QCursor(Qt.CursorShape(val)))

    @Slot()
    def restoreOverrideCursor(self):
        QGuiApplication.restoreOverrideCursor()

    @Slot(QObject)
    def deleteLater(self, val: QObject):
        if val is not None:
            val.deleteLater()

    @Slot(QColor, float, result=QColor)
    def withOpacity(self, color: QColor, opacity: float) -> QColor:
        alpha = int(opacity * 255) & 0xff
        return QColor.fromRgba((alpha << 24) | (color.rgba() & 0xffffff))

    @Slot(result=int)
    def cursorScreenIndex(self) -> int:
        screenIndex = 0
        screenCount = len(QGuiApplication.screens())
        if screenCount > 1:
            pos = QCursor.pos()
            for i in range(screenCount):
                if QGuiApplication.screens()[i].geometry().contains(pos):
                    screenIndex = i
                    break
        return screenIndex

    @Slot(result=bool)
    def isWindows11OrGreater(self) -> bool:
        var = getattr(self, "_isWindows11OrGreater", None)
        if var is None:
            if sys.platform.startswith("win"):
                buildNumber: int = windowBuildNumber()
                if buildNumber >= 22000:
                    var = True
                else:
                    var = False
            else:
                var = False
            setattr(self, "_isWindows11OrGreater", var)
        return bool(var)


__tools = None


def Tools() -> __Tools:
    global __tools
    if __tools is None:
        __tools = __Tools()
    return __tools
