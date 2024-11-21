import sys
from FluentUI.Controls import FluentUIControlsPlugin
from FluentUI.impl import FluentUIImplPlugin
from PySide6.QtGui import QGuiApplication
# noinspection PyUnresolvedReferences
from FluentUI import resource_rc

__uri__ = "FluentUI"
__major__ = 1
__minor__ = 0


def registerTypes():
    if sys.platform.startswith("win"):
        font = QGuiApplication.font()
        font.setFamily("微软雅黑")
        QGuiApplication.setFont(font)
    FluentUIImplPlugin.registerTypes()
    FluentUIControlsPlugin.registerTypes()
