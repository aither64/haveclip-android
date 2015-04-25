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
    }

    Flickable {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn

            GroupBox {
                Layout.fillWidth: true
                title: qsTr("Encryption")

                ColumnLayout {
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
                        width: parent.width
                        label: qsTr("Certificate path")
                        placeholderText: qsTr("certificate path")
                        text: settings.certificatePath
                    }

                    Binding {
                        target: settings
                        property: "certificatePath"
                        value: certificate.text
                    }

                    LabelTextField {
                        id: privateKey
                        width: parent.width
                        label: qsTr("Private key")
                        placeholderText: qsTr("Private key")
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
                Layout.fillWidth: true
                title: qsTr("Identity")

                ColumnLayout {
                    visible: !helpers.selfSslCertificate.null

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Common name")
                        text: helpers.selfSslCertificate.commonName
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Organization")
                        text: helpers.selfSslCertificate.organization
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Organization unit")
                        text: helpers.selfSslCertificate.organizationUnit
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Issued on")
                        text: Qt.formatDateTime(helpers.selfSslCertificate.issuedOn, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Expires on")
                        text: Qt.formatDateTime(helpers.selfSslCertificate.expiryDate, "d/M/yyyy")
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("Organization")
                        text: helpers.selfSslCertificate.organization
                        readOnly: true
                    }

                    LabelTextField {
                        width: parent.width
                        label: qsTr("SHA-1 Fingerprint")
                        text: helpers.selfSslCertificate.sha1Digest
                        readOnly: true
                    }
                }
            }
        }
    }
}
