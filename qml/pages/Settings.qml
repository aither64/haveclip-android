import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

BasePage {
    id: page
    pageTitle.text: "Settings"

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

    toolBar: RowLayout {
        ToolButton {
            text: qsTr("Reset settings")
            onClicked: confirmReset.open()
        }
    }

    pageComponent: ListView {
        anchors.fill: parent
        model: settingsModel
        delegate: Label {
            height: 50
            text: title

            MouseArea {
                anchors.fill: parent
                onClicked: pushPage(Qt.resolvedUrl("settings/" + page))
            }
        }
    }
}
