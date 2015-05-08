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
            implicitWidth: 24
            implicitHeight: 24
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
                width: 19
                height: 3
                x: 6
                y: 11
            }

            Rectangle {
                visible: control.checked
                color: "#ffffff"
                border.color: "#ffffff"
                radius: 1
                rotation: 45
                width: 9
                height: 3
                x: 1
                y: 13
            }
        }

        label: Label {
            id: label
            x: 5
            width: switchItem.parent.width - 24 - x
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignVCenter
            text: control.text
        }
    }
}
