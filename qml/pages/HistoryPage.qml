import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import cz.havefun.haveclip 1.0

BasePage {
    id: historyPage
    pageTitle.text: "Clipboard history"

    toolBar: RowLayout {
        ToolButton {
            text: qsTr("Settings")
            onClicked: pushPage(Qt.resolvedUrl("Settings.qml"))
        }
    }

    pageComponent: ListView {
        id: listView
        model: historyModel
        anchors.fill: parent

        delegate: Item {
            id: delegate
            height: 30

            function formatItem(str) {
                var ret = str.trim().slice(0, 30);

                if(str.length > 30)
                    ret += "...";

                else if(!str.length)
                    ret = "<empty>";

                return ret;
            }

            Label {
                text: formatItem(plaintext)
            }
        }
    }
}
