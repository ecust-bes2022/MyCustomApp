import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Item{
    width: parent.width
    height: 460
    property list<QtObject> originalItems : [
        PaneItem{
            key: "/"
            title: "Home"
            icon.name: FluentIcons.graph_Home
        },
        PaneItemSeparator{},
        PaneItemHeader{
            title: "Header Item"
        },
        PaneItem{
            key: "/test/track"
            title: "Track orders"
        },
        PaneItem{
            title: "Disabled Item"
            enabled: false
        },
        PaneItemExpander{
            title: "Account"
            icon.name: FluentIcons.graph_CheckboxComposite
            PaneItemHeader{
                title: "Apps"
            }
            PaneItem{
                key: "/test/mail"
                title: "Mail"
            }
            PaneItem{
                key: "/test/calendar"
                title: "Calendar"
            }
        },
        PaneItem{
            key: "/test/newitem"
            title: "New Item"
        }
    ]
    property list<QtObject> originalFooterItems : [
        PaneItem{
            icon.name: FluentIcons.graph_Settings
            key: "/test/settings"
            title: "Settings"
        },
        PaneItem{
            icon.name: FluentIcons.graph_Contact
            key: "/test/addnewitem"
            title: "Add New Item"
        }
    ]
    PageRouter{
        id: page_router
        routes: {
            "/": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/track": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/mail": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/calendar": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/newitem": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/settings": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml",
            "/test/addnewitem": "qrc:/qt/qml/MyCustomApp/res/qml/pages/T_Test.qml"
        }
    }
    NavigationView{
        anchors.fill: parent
        logo: "qrc:/qt/qml/MyCustomApp/res/image/logo.png"
        title: "FluentUI Gallery"
        router: page_router
        items: originalItems
        footerItems: originalFooterItems
        displayMode: NavigationViewType.Open
        sideBarShadow: false
        leading: Button{
            height: 40
            highlighted: true
            text: "Custom Header Content"
        }
        trailing: Button{
            height: 40
            text: "Custom Header Content"
        }
        onTap:
            (item)=>{
                if(item.key){
                    page_router.go(item.key,{info:item.title})
                }
            }
        Component.onCompleted: {
            page_router.go("/",{info:"Home"})
        }
    }
}
