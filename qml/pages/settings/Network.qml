import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Network")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
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
                title: qsTr("Listen on")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    LabelTextField {
                        id: host
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("IP address or hostname")
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
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Port")
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
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Auto discovery")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    TextSwitch {
                        id: allowAutoDiscovery
                        text: qsTr("Allow this device to be auto-discovered in LAN")
                        checked: settings.allowAutoDiscovery

                        Binding {
                            target: settings
                            property: "allowAutoDiscovery"
                            value: allowAutoDiscovery.checked
                        }
                    }

                    LabelTextField {
                        id: networkName
                        anchors.left: parent.left
                        anchors.right: parent.right
                        label: qsTr("Network name")
                        text: settings.networkName

                        Binding {
                            target: settings
                            property: "networkName"
                            value: networkName.text
                        }
                    }

                    Rectangle {
                        Layout.preferredHeight: 5 * A.dp
                    }
                }
            }

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Limits")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15 * A.dp

                    TextSlider {
                        id: maxSendSize
                        Layout.preferredWidth: parent.width
                        label: qsTr("Max clipboard size to send")
                        value: settings.maxSendSize / 1024 / 1024
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        valueText: value + " MB"
                    }

                    Binding {
                        target: settings
                        property: "maxSendSize"
                        value: maxSendSize.value * 1024 * 1024
                    }

                    TextSlider {
                        id: maxRecvSize
                        Layout.preferredWidth: parent.width
                        label: qsTr("Max clipboard size to receive")
                        value: settings.maxReceiveSize / 1024 / 1024
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        valueText: value + " MB"
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
