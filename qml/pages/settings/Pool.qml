import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

Activity {
    id: poolPage

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Pool")
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

    Dialog {
        id: confirmDeleteAll
        standardButtons: StandardButton.No | StandardButton.Yes
        onYes: nodeModel.deleteAll()

        ColumnLayout {
            Label {
                Layout.maximumWidth: poolPage.width - 60
                text: qsTr("Do you really want to delete all nodes?")
                wrapMode: Text.Wrap
            }
        }
    }

    PopupMenu {
        id: popupMenu
        anchors.right: parent.right
        anchors.top: actionBar.bottom
        model: ListModel {
            ListElement {
                actionId: 0
                title: qsTr("Add node")
            }

            ListElement {
                actionId: 1
                title: qsTr("Delete all")
            }
        }
        onItemSelected: {
            popupMenu.active = false;

            switch (model.actionId) {
            case 0:
                start(Qt.resolvedUrl("verificationwizard/Search.qml"))
                break;

            case 1:
                confirmDeleteAll.open();
                break;
            default:
                break;
            }
        }
        z: 10000
    }

    NodeModel {
        id: nodeModel
    }

    Flickable {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: listView.height

        ListView {
            id: listView
            width: parent.width
            model: nodeModel

            delegate: QuickButton {
                width: parent.width
                height: 40 * A.dp

                Text {
                    text: name.length ? name : (host + ":" + port)
                    anchors.left: parent.left
                    anchors.leftMargin: 10 * A.dp
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Style.theme.smallText.textSize * A.dp
                    color : Style.theme.black87
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1 * A.dp
                    color : "#1A0000"
                }

                PopupMenu {
                    id: itemMenu
                    model: ListModel {
                        ListElement {
                            title: qsTr("Delete")
                        }
                    }
                    onItemSelected: {
                        popupMenu.active = false;
                        nodeModel.removeId(id);
                    }
                }

                onClicked: {
                    var n = nodeModel.nodeAt(index);
                    var dialog = start(Qt.resolvedUrl("Node.qml"), {
                        "node": n,
                        "name": n.name,
                        "host": n.host,
                        "port": n.port,
                        "sendEnabled": n.sendEnabled,
                        "recvEnabled": n.receiveEnabled
                    });

                    dialog.closed.connect(function() {
                        if (dialog.shouldDelete)
                            nodeModel.remove(dialog.node);

                         else
                            nodeModel.update(dialog.node);
                    });
                }

                onPressAndHold: {
                    var parent_x = poolPage.x + poolPage.width;
                    var parent_y = poolPage.y + poolPage.height;
                    var w = itemMenu.width;
                    var h = itemMenu.height;

                    itemMenu.x = mouse.x + w > parent_x ? mouse.x - w : mouse.x;
                    itemMenu.y = mouse.y + h > parent_y ? mouse.y - h : mouse.y;
                    itemMenu.toggle();
                }

            }
        }
    }
}
