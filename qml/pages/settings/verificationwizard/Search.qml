import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
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

    NodeDiscoveryModel {
        id: discoveryModel
    }

    Flickable {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10 * A.dp
        anchors.leftMargin: 10 * A.dp
        anchors.rightMargin: 10 * A.dp
        contentHeight: mainColumn.height

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 10 * A.dp

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Enter IP address and port")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right

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
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            var dialog = start(Qt.resolvedUrl("Verify.qml"), {
                                host: addrField.text,
                                port: parseInt(portField.text)
                            });

                            dialog.closed.connect(function() {
                                if (dialog.isOk)
                                    back();
                            });
                        }
                    }
                }
            }

            Button {
                text: qsTr("Search local network")
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: discoveryModel.discover()
            }

            ListView {
                id: discoveryView
                anchors.left: parent.left
                anchors.right: parent.right
                model: discoveryModel
                Layout.minimumHeight: 50 * discoveryView.count * A.dp
                Layout.fillHeight: true

                delegate: Item {
                    id: delegate
                    width: parent.width
                    height: 50 * A.dp

                    ColumnLayout {
                        width: parent.width

                        Label {
                            text: name
                            color: Style.theme.black87
                        }

                        Label {
                            font.pixelSize: Style.theme.smallText.textSize * A.dp
                            text: host + ":" + port
                            color: Style.theme.black54
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 1 * A.dp
                            color : "#1A000000"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            addrField.text = host
                            portField.text = port
                        }
                    }
                }
            }
        }
    }
}
