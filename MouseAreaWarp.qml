import QtQuick 2.14
import QtQml 2.15

import MouseCursorHelper 1.0

Item {
    id: root

    property alias acceptedButtons: mouseArea.acceptedButtons
    property alias containsMouse: mouseArea.containsMouse
    property alias containsPress: mouseArea.containsPress
    property alias enabled: mouseArea.enabled
    property alias pressedButtons: mouseArea.pressedButtons
    property alias hoverEnabled: mouseArea.hoverEnabled
    property alias pressed: mouseArea.pressed

    property var mouseFrame: null

    property bool hideMouseCursor: true

    signal positionChanged(delta: point)
    signal doubleClicked(position: point)

    MouseCursorHelper {
        id: mouseCursorHelper
        target: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: false

        property bool hideCursor: false

        property point _originalCursorPos
        property point _relMouse: mapToItem(center, mouseX, mouseY)

        Item {
            id: center
            anchors.centerIn: parent
        }

        Binding on cursorShape {
            when: mouseArea.hideCursor
            value: Qt.BlankCursor
            restoreMode: Binding.RestoreBindingOrValue
        }

        onCursorShapeChanged: {
            console.log(this,'cursorShape','changed',cursorShape)
        }

        onPressed: {
            console.log(this,'pressed')
            _originalCursorPos = mouseCursorHelper.cursorPosition
            if(hideMouseCursor) hideCursor = true
            mouseCursorHelper.localCursorPosition = Qt.point(center.x, center.y)
        }

        onPositionChanged: {
            console.log(this,'positionChanged',_relMouse.x,_relMouse.y,'pressed',pressed)
            if(!pressed) return
            root.positionChanged(_relMouse)
            mouseCursorHelper.localCursorPosition = Qt.point(center.x, center.y)
        }

        onReleased: {
            console.log(this,'released')
            mouseCursorHelper.cursorPosition = _originalCursorPos
            if(hideMouseCursor) hideCursor = false
        }

        onDoubleClicked: {
            root.doubleClicked()
        }
    }
}
