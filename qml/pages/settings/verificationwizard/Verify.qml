import QtQuick 2.4
import QtQuick.Controls 1.3
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0


Activity {
    id: dialog

    property string host
    property int port
    property int nodeId: 0
    property bool introduced: false
    property bool error: false
    property bool isOk: false
    signal closed

    ActionBar {
        id: actionBar
        upEnabled: true
        title: dialog.introduced ? qsTr("Verification code") : qsTr("Connecting...")
        showTitle: true

        onActionButtonClicked: {
            back();
            closed();
        }
        z: 10
    }


    Flickable {
        id: flickable
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        BusyIndicator {
            anchors.centerIn: parent
            running: !dialog.introduced && !error
        }

        Column {
            id: column
            width: parent.width
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                visible: dialog.introduced
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: qsTr(
                          "Please go to "
                          + helpers.verifiedNode().name
                          + " and type in the security code shown below."
                    )
                wrapMode: Text.Wrap
            }
        }

        Label {
            id: errorLabel
            width: parent.width
            visible: false
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            wrapMode: Text.Wrap
        }

        Label {
            visible: dialog.introduced && !dialog.error
            anchors.centerIn: parent
            text: qsTr("Security code:") + " " + conman.securityCode
        }
    }

    Timer {
        id: verifyTimer
        interval: 100
        repeat: false
        onTriggered: {
            if (nodeId > 0)
                conman.verifyConnection(nodeId);
            else
                conman.verifyConnection(host, port);

            console.log("host = " + host, ", port = ", port, ", node id = ", nodeId);
        }
    }

    Component.onCompleted: {
        var d = dialog

        conman.introductionFinished.connect(function(){
            d.introduced = true

            // refresh node name shown in the label above
            helpers.verifiedNode()
        })

        conman.introductionFailed.connect(function(status){
            d.error = true
            errorLabel.text = "Error occured:\n" + helpers.communicationStatusToString(status)
            errorLabel.visible = true
        })

        conman.verificationFinished.connect(function(status){
            switch(status) {
            case ConnectionManager.Valid:
                d.isOk = true;
                back();
                closed();

            case ConnectionManager.NotValid:
                break;

            case ConnectionManager.Refused:
                d.error = true
                errorLabel.text = qsTr("You have run out of tries. Please repeat the verification process.")
                errorLabel.visible = true
                break;
            }
        })

        dialog.introduced = false

        // The timer here is necessary, because host and port properties are
        // not set yet. They are set after component creation.
        verifyTimer.start()
    }
}
