import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl
import MyCustomApp

StackPage {
    router: PageRouter{
        routes: {
            "/": {url: R.resolvedUrl("res/qml/page/T_Material.qml"),singleton:true},
            "/subpage":  R.resolvedUrl("res/qml/page/T_SubPage.qml"),
        }
    }
    Component.onCompleted: {
        router.go("/")
    }
}
