import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import cz.havefun.haveclip 1.0

ApplicationWindow {
    title: qsTr("HaveClip")
    width: 1200
    height: 700
    visible: true

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    StackView {
        id: pageView
        anchors.fill: parent
        initialItem: HistoryPage {}

        onCurrentItemChanged: {
            console.log("stack item", currentItem, currentItem.width, currentItem.height)
        }
    }

    Component.onCompleted: {
        Qt.application.stateChanged.connect(function(s) {
            if (s === Qt.ApplicationActive)
                manager.checkClipboard();
        });
    }
}
