import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

ScrollablePage {

    title: qsTr("Shimmer")

    columnSpacing: 20

    Shimmer{
      Layout.preferredWidth: layout_column.width
      Layout.preferredHeight: layout_column.height
      Column{
          id: layout_column
          spacing: 20
          width: 560
          Repeater{
              model: 4
              delegate: Frame{
                  implicitWidth: layout_column.width
                  implicitHeight: 140

                  Rectangle{
                      id: avatar
                      width: 100
                      height: 100
                      radius: 50
                      color: Theme.res.dividerStrokeColorDefault
                      anchors{
                          verticalCenter: parent.verticalCenter
                          left: parent.left
                          leftMargin: 20
                      }
                  }
                  Rectangle{
                      width: 400
                      height: 32
                      radius: 4
                      color: Theme.res.dividerStrokeColorDefault
                      anchors{
                          top: avatar.top
                          left: avatar.right
                          topMargin: 6
                          leftMargin: 20
                      }
                  }
                  Rectangle{
                      width: 200
                      height: 32
                      radius: 4
                      color: Theme.res.dividerStrokeColorDefault
                      anchors{
                          bottom: avatar.bottom
                          left: avatar.right
                          bottomMargin: 6
                          leftMargin: 20
                      }
                  }
              }
          }
      }
    }


}
