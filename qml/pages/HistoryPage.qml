import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
    id: historyPage

    ActionBar {
        id: actionBar
        title: qsTr("Clipboard history")
        z: 10
        actionButtonEnabled: false

        menuBar : QuickButton {
            icon : Qt.resolvedUrl("../../drawable-xxhdpi/ic_menu.png")
            onClicked:  {
                popupMenu.toggle();
            }
            opacity: 0.87
        }
    }

    PopupMenu {
        id: popupMenu
        anchors.right: parent.right
        anchors.top: actionBar.bottom
        model: ListModel {
            ListElement {
                title: qsTr("Settings")
                page: "Settings.qml"
            }
        }
        onItemSelected: {
            popupMenu.active = false;
            start(Qt.resolvedUrl(model.page));
        }
        z: 10000
    }

    ListView {
        id: listView
        model: historyModel
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        delegate: QuickButton {
            width: parent.width
            height: 40 * A.dp

            Text {
                text: formatItem(plaintext)
                anchors.left: parent.left
                anchors.leftMargin: 10 * A.dp
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Style.theme.smallText.textSize * A.dp
                color : Style.theme.black87
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1 * A.dp
                color : "#1A0000"
            }

            onClicked: start(Qt.resolvedUrl("settings/" + model.page))

            function formatItem(str) {
                var ret = str.trim().slice(0, 30);

                if(str.length > 30)
                    ret += "...";

                else if(!str.length)
                    ret = "<empty>";

                return ret;
            }
        }
    }
}
