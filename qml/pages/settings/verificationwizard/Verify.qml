import QtQuick 2.4
import QtQuick.Controls 1.3
import cz.havefun.haveclip 1.0


BasePage {
    id: dialog

    property string host
    property int port
    property int nodeId: 0
    property bool introduced: false
    property bool error: false

    pageTitle.text: dialog.introduced ? qsTr("Verification code") : qsTr("Connecting...")

    Component {
        id: page

        Flickable {
            id: flickable
            anchors.fill: parent

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
    }

    pageComponent: page

    function accept() {
        console.log("would accept")
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
                d.accept()

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

        if(nodeId > 0)
            conman.verifyConnection(nodeId)
        else
            conman.verifyConnection(host, port)

        console.log("host = " + host, ", port = ", port, ", node id = ", nodeId)
    }
}
