import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

Activity {
    id: nodePage

    property Node node: null
    property alias name: nameField.text
    property alias host: addrField.text
    property alias port: portField.text
    property alias sendEnabled: sendEnabled.checked
    property alias recvEnabled: recvEnabled.checked
    property bool shouldDelete: false
    signal closed

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Edit node")
        showTitle: true

        onActionButtonClicked: {
            back();
            closed();
        }
        z: 10

        menuBar : QuickButton {
            icon : Qt.resolvedUrl("../../../drawable-xxhdpi/ic_menu.png")
            onClicked:  {
                popupMenu.toggle();
            }
            opacity: 0.87
        }
    }

    PopupMenu {
        id: popupMenu
        anchors.right: parent.right
        anchors.top: actionBar.bottom
        model: ListModel {
            ListElement {
                actionId: 0
                title: qsTr("New identity verification")
            }

            ListElement {
                actionId: 1
                title: qsTr("Delete node")
            }
        }
        onItemSelected: {
            popupMenu.active = false;

            switch (model.actionId) {
            case 0:
                var dialog = start(Qt.resolvedUrl("verificationwizard/Verify.qml"), {
                    "nodeId": nodePage.node.id
                });

                dialog.closed.connect(function() {
                    if (dialog.isOk)
                        nodePage.node.update();
                });
                break;

            case 1:
                confirmDelete.open();
                break;

            default:
                break;
            }
        }
        z: 10000
    }

    Dialog {
        id: confirmDelete
        standardButtons: StandardButton.No | StandardButton.Yes
        onYes: {
            nodePage.shouldDelete = true;
            back();
            closed();
        }

        ColumnLayout {
            Label {
                Layout.maximumWidth: nodePage.width - 60
                text: qsTr("Do you really want to delete this node?")
                wrapMode: Text.Wrap
            }
        }
    }

    Flickable {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10 * A.dp
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Description")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    LabelTextField {
                        id: nameField
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Name")
                        validator: RegExpValidator {
                            regExp: /.+/
                        }
                    }

                    Binding {
                        target: node
                        property: "name"
                        value: nameField.text
                    }

                    LabelTextField {
                        id: addrField
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("IP address/hostname")
                        validator: RegExpValidator {
                            regExp: /^[^\s]+$/
                        }
                    }

                    Binding {
                        target: node
                        property: "host"
                        value: addrField.text
                    }

                    LabelTextField {
                        id: portField
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Port")
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: IntValidator {
                            bottom: 1
                            top: 65535
                        }
                    }

                    Binding {
                        target: node
                        property: "port"
                        value: parseInt(portField.text)
                    }
                }
            }

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Synchronization")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    TextSwitch {
                        id: sendEnabled
                        text: qsTr("Send the clipboard to this node")
                    }

                    Binding {
                        target: node
                        property: "sendEnabled"
                        value: sendEnabled.checked
                    }

                    TextSwitch {
                        id: recvEnabled
                        text: qsTr("Receive the clipboard from this node")
                    }

                    Binding {
                        target: node
                        property: "receiveEnabled"
                        value: recvEnabled.checked
                    }
                }
            }

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Identity")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Common name")
                        text: node.sslCertificate.commonName
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Organization")
                        text: node.sslCertificate.organization
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Organization unit")
                        text: node.sslCertificate.organizationUnit
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Issued on")
                        text: Qt.formatDateTime(node.sslCertificate.issuedOn, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Expires on")
                        text: Qt.formatDateTime(node.sslCertificate.expiryDate, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("SHA-1 Fingerprint")
                        text: node.sslCertificate.sha1Digest
                        readOnly: true
                    }
                }
            }
        }
    }
}
