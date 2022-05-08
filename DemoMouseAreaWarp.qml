import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root
    property string title: "MouseAreaWarp Demo"
    implicitHeight: column.implicitHeight

    Column {
        id: column
        spacing: 10

        Text {
            width: root.width
            text: title
            font.pixelSize: 30
        }

        Text {
            width: root.width
            text: "This widget works like a MouseArea, but captures the mouse, and resets the mouse cursor to its center via a C++ helper, allowing infinite dragging."
            wrapMode: Text.WordWrap
        }

        Rectangle {
            width: 400
            height: 300
            color: mouseArea.pressed ? "green" : "lightGray"

            MouseAreaWarp {
                id: mouseArea
                anchors.fill: parent
                hideMouseCursor: chkHideMouseCursor.checked
            }
        }

        Text {
            width: root.width
            text: "You can better see the functioning of the widget by setting the 'hideMouseCursor' property to false, via this checkbox:"
            wrapMode: Text.WordWrap
        }

        CheckBox {
            id: chkHideMouseCursor
            checked: true
            text: "hideMouseCursor"
        }
    }
}
