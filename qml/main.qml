import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Application {
    width: 1200
    height: 700

    Loader {
        id: loader
        onLoaded: {
            var l = loader;

            item.closed.connect(function() {
                l.source = "";
            });
        }
    }

    Component.onCompleted: {
        Qt.application.stateChanged.connect(function(s) {
            if (s === Qt.ApplicationActive)
                manager.checkClipboard();
        });

        conman.verificationRequested.connect(function(){
            loader.source = Qt.resolvedUrl("pages/settings/verificationwizard/Prompt.qml");
        });

        start(Qt.resolvedUrl("pages/HistoryPage.qml"));
    }
}
