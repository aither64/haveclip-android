import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

Dialog {
    id: dialog

    property Node node: helpers.verifiedNode()
    property bool refused: false
    signal closed

    title: qsTr("Verify")
    standardButtons: StandardButton.Cancel | StandardButton.Ok
    onAccepted: {
        if (!refused)
            conman.provideSecurityCode(securityCode.text);
    }

    onRejected: {
        close();
        closed();
    }


    ColumnLayout {
        id: column

        Label {
            Layout.fillWidth: true
            text: qsTr("Verification request from " + dialog.node.name)
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Label {
            id: errorLabel
            visible: false
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        LabelTextField {
            id: securityCode
            visible: !refused
            Layout.fillWidth: true
            Layout.fillHeight: true
            label: qsTr("Security code")
            placeholderText: qsTr("Enter the security code")
            validator: RegExpValidator {
                regExp: /^[0-9]{6}$/
            }
            inputMethodHints: Qt.ImhDigitsOnly
            focus: true
        }
    }

    Component.onCompleted: {
        var prompt = dialog;
        var error = errorLabel;

        conman.verificationFinished.connect(function(valid){
            switch(valid)
            {
            case ConnectionManager.Valid:
                prompt.close();
                closed();
                break;

            case ConnectionManager.NotValid:
                error.text = qsTr("The provided code is not valid.\nPlease try again.");
                error.visible = true;
                open();
                break;

            case ConnectionManager.Refused:
                error.text = qsTr("The verification was not accepted.\nPlease repeat the process.");
                error.visible = true;
                prompt.refused = true;
                open();
                break;
            }


        });

        conman.verificationFailed.connect(function(status){
            error.text = qsTr("Connection error:\n" + helpers.communicationStatusToString(status))
            error.visible = true
            prompt.refused = true
        });

        prompt.open();
    }
}
