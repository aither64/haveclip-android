import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QuickAndroid 0.1

Item {
    id: groupBox

    property alias title: groupLabel.text
    default property alias contents: placeholder.children

    height: layout.height

    ColumnLayout {
        id: layout
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5 * A.dp

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 15 * A.dp
            anchors.rightMargin: 15 * A.dp
            Layout.preferredHeight: 20 * A.dp

            Label {
                id: groupLabel
                anchors.left: parent.left
                anchors.right: parent.right
                y: 1
                font.weight: Font.DemiBold
            }
        }

        Rectangle {
            color: "#eaeaea"
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Rectangle {
            Layout.minimumHeight: 5 * A.dp
            Layout.maximumHeight: 5 * A.dp
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 15 * A.dp
            anchors.rightMargin: 15 * A.dp
            height: placeholder.childrenRect.height

            Item {
                id: placeholder
                anchors.left: parent.left
                anchors.right: parent.right
                height: childrenRect.height
            }
        }

        Rectangle {
            Layout.minimumHeight: 5 * A.dp
            Layout.maximumHeight: 5 * A.dp
        }

        Rectangle {
            color: "#eaeaea"
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
