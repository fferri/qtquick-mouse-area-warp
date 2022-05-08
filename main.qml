import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Demos")

    ComboBox {
        id: combobox
        width: root.width
        model: ['DemoMouseAreaWarp']
    }

    ScrollView {
        anchors.fill: parent
        anchors.topMargin: combobox.height
        clip: true
        contentWidth: loader.width
        contentHeight: loader.height

        Loader {
            id: loader
            source: combobox.currentValue ? "qrc:/" + combobox.currentValue + ".qml" : null
            width: root.width
        }
    }
}
