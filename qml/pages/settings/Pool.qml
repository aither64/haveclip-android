import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import cz.havefun.haveclip 1.0

BasePage {
    pageTitle.text: qsTr("Pool")

    NodeModel {
        id: nodeModel
    }

    toolBar: RowLayout {
        ToolButton {
            text: qsTr("Add node")
            onClicked: pushPage(Qt.resolvedUrl("verificationwizard/Search.qml"))
        }
    }

    pageComponent: Flickable {
        anchors.fill: parent
        contentHeight: listView.height

        ListView {
            id: listView
            model: nodeModel

            delegate: Item {
                id: listItem
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
