import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QuickAndroid 0.1
import cz.havefun.haveclip 1.0

Activity {
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

    PopupMenu {
        id: popupMenu
        anchors.right: parent.right
        anchors.top: actionBar.bottom
        model: ListModel {
            ListElement {
                actionId: 0
                title: qsTr("Add node")
            }
        }
        onItemSelected: {
            switch (model.actionId) {
            case 0:
                start(Qt.resolvedUrl("verificationwizard/Search.qml"))
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

            delegate: Item {
                id: listItem
                width: listView.width
                height: 50

                Label {
                    text: name.length ? name : (host + ":" + port)
                    anchors.verticalCenter: parent.verticalCenter
                    font.capitalization: Font.Capitalize
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        var dialog = pushPage(Qt.resolvedUrl("NodeDialog.qml"), {
                            "node": nodeModel.nodeAt(index),
                        })

                        dialog.accepted.connect(function() {
                            if(dialog.shouldDelete)
                                nodeModel.remove(dialog.node)

                            else
                                nodeModel.update(dialog.node)
                        });
                    }
                }
            }
        }
    }
}
