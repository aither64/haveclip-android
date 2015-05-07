import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Row {
    property alias text: label.text
    property alias checked: switchItem.checked

    anchors.left: parent.left
    anchors.right: parent.right

    CheckBox {
        id: switchItem
    }

    Label {
        id: label
        wrapMode: Text.Wrap
        width: parent.width - switchItem.width
        verticalAlignment: Text.AlignVCenter
        height: parent.height
    }
}
