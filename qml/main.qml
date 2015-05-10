import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import cz.havefun.haveclip 1.0

Application {
    width: 1200
    height: 700

    theme : Theme {
        actionBar.background : "#90118e"
        actionBar.titleTextStyle : actionTitleStyle
        dropdown.textStyle: actionMenuStyle
        textInput.textStyle: textInputStyle

        TextStyle {
            id : actionTitleStyle
            textSize: 18
            textColor: "#ffffff"
        }

        TextStyle {
            id: actionMenuStyle
            textSize: 18
            textColor: Style.theme.black87
        }

        TextStyle {
            id: textInputStyle
            textSize: Style.theme.largeText.textSize
            textColor: Style.theme.black87
        }
    }

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
        conman.verificationRequested.connect(function(){
            loader.source = Qt.resolvedUrl("pages/settings/verificationwizard/Prompt.qml");
        });

        start(Qt.resolvedUrl("pages/History.qml"));

        if (settings.firstStart)
            start(Qt.resolvedUrl("pages/settings/security/CertificateGenerator.qml"));
    }
}
