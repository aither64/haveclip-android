import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Add node")
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
                        onClicked: start(Qt.resolvedUrl("Verify.qml"), {
                            host: addrField.text,
                            port: parseInt(portField.text)
                        })
                    }
                }
            }
        }
    }
}
