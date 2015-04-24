import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import cz.havefun.haveclip 1.0

BasePage {
    pageTitle.text: qsTr("Add node")

    pageComponent: Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn

            GroupBox {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: qsTr("Enter IP address and port")

                ColumnLayout {
                    Layout.fillWidth: true

                    LabelTextField {
                        id: addrField
                        width: parent.width
                        label: qsTr("IP address/hostname")
                        placeholderText: qsTr("IP address/hostname")
                        validator: RegExpValidator {
                            regExp: /^[^\s]+$/
                        }
                    }

                    LabelTextField {
                        id: portField
                        width: parent.width
                        label: qsTr("Port")
                        placeholderText: qsTr("Port")
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: IntValidator {
                            bottom: 1
                            top: 65535
                        }
                    }

                    Button {
                        text: qsTr("Connect")
                        onClicked: pushPage(Qt.resolvedUrl("Verify.qml"), {
                            host: addrField.text,
                            port: parseInt(portField.text)
                        })
                    }
                }
            }
        }
    }
}
