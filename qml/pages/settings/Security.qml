import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Security")
        showTitle: true

        onActionButtonClicked: back();
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
                title: qsTr("Generate new certificate")
                page: "security/CertificateGenerator.qml"
            }
        }
        onItemSelected: {
            popupMenu.active = false;

            start(Qt.resolvedUrl(model.page));
        }
        z: 10000
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
                title: qsTr("Encryption")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    Label {
                        text: qsTr("Mode")
                    }

                    ComboBox {
                        id: mode
                        width: parent.width
                        model: [qsTr("None"), qsTr("SSL"), qsTr("TLS")]
                        currentIndex: settings.encryption
                    }

                    Binding {
                        target: settings
                        property: "encryption"
                        value: mode.currentIndex
                    }

                    LabelTextField {
                        id: certificate
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Certificate path")
                        text: settings.certificatePath
                    }

                    Binding {
                        target: settings
                        property: "certificatePath"
                        value: certificate.text
                    }

                    LabelTextField {
                        id: privateKey
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Private key")
                        text: settings.privateKeyPath
                    }

                    Binding {
                        target: settings
                        property: "privateKeyPath"
                        value: privateKey.text
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
                    visible: !helpers.selfSslCertificate.null
                    spacing: 15 * A.dp

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Common name")
                        text: helpers.selfSslCertificate.commonName
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Organization")
                        text: helpers.selfSslCertificate.organization
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Organization unit")
                        text: helpers.selfSslCertificate.organizationUnit
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Issued on")
                        text: Qt.formatDateTime(helpers.selfSslCertificate.issuedOn, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Expires on")
                        text: Qt.formatDateTime(helpers.selfSslCertificate.expiryDate, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("SHA-1 Fingerprint")
                        text: helpers.selfSslCertificate.sha1Digest
                        readOnly: true
                    }
                }
            }
        }
    }
}
