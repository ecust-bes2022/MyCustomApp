import os
import sys
import resource_rc
from PySide6.QtCore import QProcess
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from FluentUI import FluentUIPlugin
from MyCustomApp import Logger
from MyCustomApp import GlobalConfig
from MyCustomApp.AppInfo import AppInfo

_uri = "MyCustomApp"
_major = 1
_minor = 0

if __name__ == "__main__":
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "FluentUI"
    QGuiApplication.setOrganizationName(GlobalConfig.application_company)
    QGuiApplication.setOrganizationDomain(GlobalConfig.application_domain)
    QGuiApplication.setApplicationName(GlobalConfig.application_name)
    QGuiApplication.setApplicationDisplayName(GlobalConfig.application_name)
    QGuiApplication.setApplicationVersion(GlobalConfig.application_version)
    Logger.setup("MyCustomApp")
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.addImportPath(":/qt/qml")
    AppInfo().init(engine)
    FluentUIPlugin.registerTypes()
    qml_file = "qrc:/qt/qml/MyCustomApp/App.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    result = QGuiApplication.exec()
    if result == 931:
        QProcess.startDetached(QGuiApplication.instance().applicationFilePath(), QGuiApplication.instance().arguments())
