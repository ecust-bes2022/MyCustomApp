pragma Singleton

import QtQuick

QtObject {
    readonly property font display: Qt.font({pixelSize : 62, weight: Font.DemiBold})
    readonly property font titleLarge: Qt.font({pixelSize : 37, weight: Font.DemiBold})
    readonly property font title: Qt.font({pixelSize : 26, weight: Font.DemiBold})
    readonly property font subtitle: Qt.font({pixelSize : 19, weight: Font.DemiBold})
    readonly property font bodyLarge: Qt.font({pixelSize : 17, weight: Font.Normal})
    readonly property font bodyStrong: Qt.font({pixelSize : 13, weight: Font.DemiBold})
    readonly property font body: Qt.font({pixelSize : 13, weight: Font.Normal})
    readonly property font caption: Qt.font({pixelSize : 12, weight: Font.Normal})
}
