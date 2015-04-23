import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import cz.havefun.haveclip 1.0

BasePage {
    pageTitle.text: "Clipboard"

    pageComponent: Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn

            GroupBox {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: qsTr("Listen on")

                ColumnLayout {
                    Layout.fillWidth: true

                    LabelTextField {
                        id: host
                        width: parent.width
                        label: qsTr("IP address or hostname")
                        placeholderText: qsTr("IP address or hostname")
                        text: settings.host
                        validator: RegExpValidator {
                            regExp: /^[^\s]+$/
                        }
                    }

                    Binding {
                        target: settings
                        property: "host"
                        value: host.text
                    }

                    LabelTextField {
                        id: port
                        width: parent.width
                        label: qsTr("Port")
                        placeholderText: qsTr("Port")
                        text: settings.port
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: IntValidator {
                            bottom: 1024
                            top: 65535
                        }
                    }

                    Binding {
                        target: settings
                        property: "port"
                        value: parseInt(port.text)
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: qsTr("Auto discovery")

                ColumnLayout {
                    Layout.preferredWidth: parent.width

                    CheckBox {
                        id: allowAutoDiscovery
                        text: qsTr("Allow this device to be auto-discovered in LAN")
                        checked: settings.allowAutoDiscovery
                    }

                    Binding {
                        target: settings
                        property: "allowAutoDiscovery"
                        value: allowAutoDiscovery.checked
                    }

                    LabelTextField {
                        id: networkName
                        width: parent.width
                        label: qsTr("Network name")
                        placeholderText: qsTr("network name")
                        text: settings.networkName
                    }

                    Binding {
                        target: settings
                        property: "networkName"
                        value: networkName.text
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: qsTr("Auto discovery")

                ColumnLayout {
                    Layout.preferredWidth: parent.width

                    Label {
                        text: qsTr("Max clipboard size to send")
                    }

                    Slider {
                        id: maxSendSize
                        Layout.preferredWidth: parent.width
                        value: settings.maxSendSize / 1024 / 1024
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                    }

                    Binding {
                        target: settings
                        property: "maxSendSize"
                        value: maxSendSize.value * 1024 * 1024
                    }

                    Label {
                        text: qsTr("Max clipboard size to receive")
                    }

                    Slider {
                        id: maxRecvSize
                        Layout.preferredWidth: parent.width
                        value: settings.maxReceiveSize / 1024 / 1024
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                    }

                    Binding {
                        target: settings
                        property: "maxReceiveSize"
                        value: maxRecvSize.value * 1024 * 1024
                    }
                }
            }
        }
    }
}
