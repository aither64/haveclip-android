import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import QtQuick.Dialogs 1.2
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
                actionId: 0
                title: qsTr("Settings")
                page: "Settings.qml"
            }

            ListElement {
                actionId: 1
                title: qsTr("Clear history")
            }
        }
        onItemSelected: {
            popupMenu.active = false;

            switch (model.actionId) {
            case 0:
                start(Qt.resolvedUrl(model.page));
                break;

            case 1:
                confirmClear.open();
                break;
            }
        }
        z: 10000
    }

    Dialog {
        id: confirmClear
        standardButtons: StandardButton.No | StandardButton.Yes
        onYes: historyModel.clear()

        ColumnLayout {
            Label {
                Layout.maximumWidth: historyPage.width - 60
                text: qsTr("Do you really want to clear the history?")
                wrapMode: Text.Wrap
            }
        }
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
