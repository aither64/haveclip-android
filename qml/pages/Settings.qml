import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import cz.havefun.haveclip 1.0

BasePage {
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
