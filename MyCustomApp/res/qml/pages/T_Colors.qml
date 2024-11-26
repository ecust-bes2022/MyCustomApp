import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ScrollablePage {

    title: qsTr("Colors Showcase")
    columnSpacing: 24
    Component{
        id: comp_color_block
        Rectangle{
            implicitWidth: 80
            implicitHeight: 80
            color: model.color()
            Label{
                text: model.name
                font: Typography.bodyStrong
                color: Colors.basedOnLuminance(parent.color)
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 10
                }
            }
        }
    }

    Component{
        id: comp_accent_color_block
        Column{
            property var accentColor: model.color()
            property var accentName: model.name
            width: 80
            height: 560
            spacing: 0
            ListModel{
                id: accent_color_model
                ListElement{
                    name: "darkest"
                    color: function(){return accentColor.darkest()}
                }
                ListElement{
                    name: "darker"
                    color: function(){return accentColor.darker()}
                }
                ListElement{
                    name: "dark"
                    color: function(){return accentColor.dark()}
                }
                ListElement{
                    name: "normal"
                    color: function(){return accentColor.normal}
                }
                ListElement{
                    name: "light"
                    color: function(){return accentColor.light()}
                }
                ListElement{
                    name: "lighter"
                    color: function(){return accentColor.lighter()}
                }
                ListElement{
                    name: "lightest"
                    color: function(){return accentColor.lightest()}
                }
            }
            Repeater{
                model: accent_color_model
                delegate: Rectangle{
                    property color textColor: Colors.basedOnLuminance(color)
                    width: 80
                    height: 80
                    color: model.color()
                    Label{
                        text: accentName
                        font: Typography.bodyStrong
                        color: textColor
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 10
                        }
                    }
                    Label{
                        text: model.name
                        color: textColor
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 10
                        }
                    }
                }
            }

        }
    }

    GroupBox{
        title: qsTr("Primary Colors")
        Layout.fillWidth: true
        Flow{
            spacing: 14
            anchors.fill: parent
            Repeater{
                model: primaryColors
                delegate: comp_color_block
            }
        }
    }

    GroupBox{
        title: qsTr("Info Colors")
        Layout.fillWidth: true
        Flow{
            spacing: 14
            anchors.fill: parent
            Repeater{
                model: infoColors
                delegate: comp_color_block
            }
        }
    }

    GroupBox{
        title: qsTr("All Shades")
        Layout.fillWidth: true
        Flow{
            spacing: 14
            anchors.fill: parent
            Repeater{
                model: allShades
                delegate: comp_color_block
            }
        }
    }

    GroupBox{
        title: qsTr("Accent Colors")
        Layout.fillWidth: true
        Flow{
            spacing: 14
            anchors.fill: parent
            Repeater{
                model: accentColors
                delegate: comp_accent_color_block
            }
        }
    }

    ListModel{
        id: primaryColors
        ListElement{
            name: "Yellow"
            color: function(){return Colors.yellow.normal}
        }
        ListElement{
            name: "Orange"
            color: function(){return Colors.orange.normal}
        }
        ListElement{
            name: "Red"
            color: function(){return Colors.red.normal}
        }
        ListElement{
            name: "Magenta"
            color: function(){return Colors.magenta.normal}
        }
        ListElement{
            name: "Purple"
            color: function(){return Colors.purple.normal}
        }
        ListElement{
            name: "Blue"
            color: function(){return Colors.blue.normal}
        }
        ListElement{
            name: "Teal"
            color: function(){return Colors.teal.normal}
        }
        ListElement{
            name: "Green"
            color: function(){return Colors.green.normal}
        }
    }

    ListModel{
        id: infoColors
        ListElement{
            name: "Warning 1"
            color: function(){return Colors.warningPrimaryColor}
        }
        ListElement{
            name: "Warning 2"
            color: function(){return Colors.warningSecondaryColor.normal}
        }
        ListElement{
            name: "Error 1"
            color: function(){return Colors.errorPrimaryColor}
        }
        ListElement{
            name: "Error 2"
            color: function(){return Colors.errorSecondaryColor.normal}
        }
        ListElement{
            name: "Success 1"
            color: function(){return Colors.successPrimaryColor}
        }
        ListElement{
            name: "Success 2"
            color: function(){return Colors.successSecondaryColor.normal}
        }
    }

    ListModel{
        id: allShades
        ListElement{
            name: "Black"
            color: function(){return Colors.black}
        }
        ListElement{
            name: "White"
            color: function(){return Colors.white}
        }
        ListElement{
            name: "Grey#10"
            color: function(){return Colors.grey10}
        }
        ListElement{
            name: "Grey#20"
            color: function(){return Colors.grey20}
        }
        ListElement{
            name: "Grey#30"
            color: function(){return Colors.grey30}
        }
        ListElement{
            name: "Grey#40"
            color: function(){return Colors.grey40}
        }
        ListElement{
            name: "Grey#50"
            color: function(){return Colors.grey50}
        }
        ListElement{
            name: "Grey#60"
            color: function(){return Colors.grey60}
        }
        ListElement{
            name: "Grey#70"
            color: function(){return Colors.grey70}
        }
        ListElement{
            name: "Grey#80"
            color: function(){return Colors.grey80}
        }
        ListElement{
            name: "Grey#90"
            color: function(){return Colors.grey90}
        }
        ListElement{
            name: "Grey#100"
            color: function(){return Colors.grey100}
        }
        ListElement{
            name: "Grey#110"
            color: function(){return Colors.grey110}
        }
        ListElement{
            name: "Grey#120"
            color: function(){return Colors.grey120}
        }
        ListElement{
            name: "Grey#130"
            color: function(){return Colors.grey130}
        }
        ListElement{
            name: "Grey#140"
            color: function(){return Colors.grey140}
        }
        ListElement{
            name: "Grey#150"
            color: function(){return Colors.grey150}
        }
        ListElement{
            name: "Grey#160"
            color: function(){return Colors.grey160}
        }
        ListElement{
            name: "Grey#170"
            color: function(){return Colors.grey170}
        }
        ListElement{
            name: "Grey#180"
            color: function(){return Colors.grey180}
        }
        ListElement{
            name: "Grey#190"
            color: function(){return Colors.grey190}
        }
        ListElement{
            name: "Grey#200"
            color: function(){return Colors.grey200}
        }
        ListElement{
            name: "Grey#210"
            color: function(){return Colors.grey210}
        }
        ListElement{
            name: "Grey#220"
            color: function(){return Colors.grey220}
        }
    }

    ListModel{
        id: accentColors
        ListElement{
            name: "Yellow"
            color: function(){return Colors.yellow}
        }
        ListElement{
            name: "Orange"
            color: function(){return Colors.orange}
        }
        ListElement{
            name: "Red"
            color: function(){return Colors.red}
        }
        ListElement{
            name: "Magenta"
            color: function(){return Colors.magenta}
        }
        ListElement{
            name: "Purple"
            color: function(){return Colors.purple}
        }
        ListElement{
            name: "Blue"
            color: function(){return Colors.blue}
        }
        ListElement{
            name: "Teal"
            color: function(){return Colors.teal}
        }
        ListElement{
            name: "Green"
            color: function(){return Colors.green}
        }
    }

}
