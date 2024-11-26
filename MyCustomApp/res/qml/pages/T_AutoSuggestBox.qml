import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI.Controls
import Gallery

ScrollablePage {

    title: qsTr("AutoSuggestBox")

    CardHighlight{
        Layout.fillWidth: true
        codeSnippet:
            `import QtQuick
import QtQuick.Controls
import FluentUI.Controls

Column{
    AutoSuggestBox{
        items: generateRandomNames(100)
        placeholderText: "AutoSuggest"
    }
    function generateRandomNames(numNames) {
        const alphabet = \'ABCDEFGHIJKLMNOPQRSTUVWXYZ\'
        const names = []
        function generateRandomName() {
            const nameLength = Math.floor(Math.random() * 5) + 4
            let name = \'\'
            for (let i = 0; i < nameLength; i++) {
                const letterIndex = Math.floor(Math.random() * 26);
                name += alphabet.charAt(letterIndex)
            }
            return name
        }
        for (let i = 0; i < numNames; i++) {
            const name = generateRandomName()
            names.push({title:name})
        }
        return names
    }
}
`}

}
