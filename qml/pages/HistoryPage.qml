import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import cz.haveclip 1.0

BasePage {
    id: historyPage
    pageTitle.text: "Clipboard history"

    property Component settingsPage: SettingsPage {

    }

    pageComponent: Button {
        text: "Open settings"
        onClicked: {
            pushPage(settingsPage);
        }
    }
}
