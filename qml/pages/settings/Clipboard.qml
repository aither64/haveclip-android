import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Clipboard")
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
                title: qsTr("Clipboard settings")

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right

                    CheckBox {
                        id: keepHistory
                        text: qsTr("Keep history")
                        checked: settings.historyEnabled
                    }

                    Binding {
                        target: settings
                        property: "historyEnabled"
                        value: keepHistory.checked
                    }

                    TextSlider {
                        id: historySize
                        Layout.preferredWidth: parent.width
                        label: qsTr("History size")
                        minimumValue: 1
                        maximumValue: 100
                        stepSize: 1
                        value: settings.historySize
                        valueText: value.toString() + " " + (value == 1 ? qsTr("entry") : qsTr("entries"))
                        enabled: keepHistory.checked
                    }

                    Binding {
                        target: settings
                        property: "historySize"
                        value: historySize.value
                    }

                    CheckBox {
                        id: saveHistory
                        text: qsTr("Save history to disk")
                        enabled: keepHistory.checked
                        checked: settings.saveHistory
                    }

                    Binding {
                        target: settings
                        property: "saveHistory"
                        value: saveHistory.checked
                    }
                }
            }

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: qsTr("Synchronization")

                ColumnLayout {
                    CheckBox {
                        id: syncEnabled
                        text: qsTr("Enable synchronization")
                        checked: settings.syncEnabled
                    }

                    Binding {
                        target: settings
                        property: "syncEnabled"
                        value: syncEnabled.checked
                    }

                    CheckBox {
                        id: sendEnabled
                        text: qsTr("Enable clipboard sending")
                        checked: settings.sendEnabled
                        enabled: syncEnabled.checked
                    }

                    Binding {
                        target: settings
                        property: "sendEnabled"
                        value: sendEnabled.checked
                    }

                    CheckBox {
                        id: recvEnabled
                        text: qsTr("Enable clipboard receiving")
                        checked: settings.recvEnabled
                        enabled: syncEnabled.checked
                    }

                    Binding {
                        target: settings
                        property: "recvEnabled"
                        value: recvEnabled.checked
                    }
                }
            }
        }
    }
}
