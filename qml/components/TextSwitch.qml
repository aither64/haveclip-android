import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1

CheckBox {
    id: switchItem

    anchors.left: parent.left
    anchors.right: parent.right

    style: CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: 18 * A.dp
            implicitHeight: 18 * A.dp
            radius: 2
            border.color: "#e3728d"
            border.width: 2
            color: control.checked ? "#e3728d" : "#ffffff"

            Rectangle {
                visible: control.checked
                color: "#ffffff"
                border.color: "#ffffff"
                radius: 1
                rotation: 135
                width: 15 * A.dp
                height: 2 * A.dp
                x: 4 * A.dp
                y: 8 * A.dp
            }

            Rectangle {
                visible: control.checked
                color: "#ffffff"
                border.color: "#ffffff"
                radius: 1
                rotation: 45
                width: 7 * A.dp
                height: 2 * A.dp
                x: 1 * A.dp
                y: 11 * A.dp
            }
        }

        label: Label {
            id: label
            x: 5 * A.dp
            width: switchItem.parent.width - (24 * A.dp) - x
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignVCenter
            text: control.text
        }
    }
}
