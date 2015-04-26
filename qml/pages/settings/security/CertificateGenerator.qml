import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import cz.havefun.haveclip 1.0

Activity {
    id: page
    property bool errorOccurred: false

    ActionBar {
        id: actionBar
        upEnabled: errorOccurred
        title: qsTr("Certificate generator")
        showTitle: true

        onActionButtonClicked: {
            back();
        }
        z: 10
    }

    CertificateGenerator {
        id: generator

        onErrorOccurred: {
            errorLabel.text = msg;
            page.errorOccurred = true;
        }

        onFinished: {
            generator.savePrivateKeyToFile(settings.privateKeyPath);
            generator.saveCertificateToFile(settings.certificatePath);
            settings.reloadIdentity();
            back();
        }
    }

    Label {
        anchors.top: actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 80 * A.dp
        anchors.leftMargin: 10 * A.dp
        anchors.rightMargin: 10 * A.dp
        text: qsTr("Generating a private key and a certificate. Please wait, "+
                   "it may take a few minutes.")
        font.pixelSize: Style.theme.mediumText.textSize * A.dp
        color : Style.theme.black87
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        visible: !errorOccurred
    }

    ProgressBar {
        anchors.centerIn: parent
        visible: !errorOccurred
        width: 200 * A.dp
        height: 10 * A.dp
        minimumValue: 0
        maximumValue: 100
        value: 0

        SequentialAnimation on value {
            running: !errorOccurred
            loops: Animation.Infinite
            PropertyAnimation { to: 100; duration: 5000 }
            PropertyAnimation { to: 0;   duration: 5000 }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        visible: errorOccurred

        Label {
            width: parent.width
            anchors.margins: 10 * A.dp
            horizontalAlignment: Text.AlignHCenter
            color: Style.theme.black87
            text: qsTr("Error occured:")
        }

        Label {
            id: errorLabel
            width: parent.width
            anchors.margins: 10 * A.dp
            horizontalAlignment: Text.AlignHCenter
            color: Style.theme.black87
            wrapMode: Text.Wrap
        }
    }

    Component.onCompleted: {
        generator.commonName = settings.networkName;
        generator.generate();
    }
}
