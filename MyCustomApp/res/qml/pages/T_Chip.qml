import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("Chip")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            'import QtQuick
import QtQuick.Controls
import FluentUI.Controls
import FluentUI.impl

Flow{
    spacing: 10
    width: parent.width - 120
    Chip{
        text: "Chip1"
        flat: true
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "Chip2"
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "yellow"
        highlighted: true
        FluentUI.primaryColor: Colors.yellow
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "orange"
        highlighted: true
        FluentUI.primaryColor: Colors.orange
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "red"
        highlighted: true
        FluentUI.primaryColor: Colors.red
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "magenta"
        highlighted: true
        FluentUI.primaryColor: Colors.magenta
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "purple"
        highlighted: true
        FluentUI.primaryColor: Colors.purple
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "blue"
        highlighted: true
        FluentUI.primaryColor: Colors.blue
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "teal"
        highlighted: true
        FluentUI.primaryColor: Colors.teal
        onCloseClicked:{ this.destroy() }
    }
    Chip{
        text: "green"
        highlighted: true
        FluentUI.primaryColor: Colors.green
        onCloseClicked:{ this.destroy() }
    }
}
'}

}
