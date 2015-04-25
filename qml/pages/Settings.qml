import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

Activity {
    id: page

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Settings")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

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
                title: qsTr("Reset settings")
            }
        }
        onItemSelected: {
            switch (model.actionId) {
            case 0:
                confirmReset.open();
                break;
            default:
                break;
            }
        }
        z: 10000
    }

    ListModel {
        id: settingsModel

        ListElement {
            page: "Clipboard.qml"
            title: qsTr("Clipboard")
        }

        ListElement {
            page: "Pool.qml"
            title: qsTr("Pool")
        }

        ListElement {
            page: "Network.qml"
            title: qsTr("Network")
        }

        ListElement {
            page: "Security.qml"
            title: qsTr("Security")
        }
    }

    Dialog {
        id: confirmReset
        standardButtons: StandardButton.No | StandardButton.Yes
        onYes: settings.reset()

        ColumnLayout {
            Label {
                Layout.maximumWidth: page.width - 60
                text: qsTr("All paired devices will be removed and you will "+
                           "have to connect them again.\n\n"+
                           "Do you really want to reset settings?")
                wrapMode: Text.Wrap
            }
        }
    }

    ListView {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: settingsModel
        delegate: QuickButton {
            width: parent.width
            height: 72 * A.dp

            Text {
                text: model.title
                anchors.left: parent.left
                anchors.leftMargin: 16 * A.dp
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Style.theme.mediumText.textSize * A.dp
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
        }
    }
}
