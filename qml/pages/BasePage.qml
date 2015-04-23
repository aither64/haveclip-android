import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    id: basePage

    signal nextPage
    signal previousPage

    property alias pageTitle: pageTitle
    property Component pageComponent
    property Component toolBar

    ColumnLayout {
        spacing: 2
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Rectangle {
            id: topBar
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 80
            color: "purple"
            border {
                color: "red"
                width: 1
            }

            RowLayout {
                Button {
                    text: "Back"
                    onClicked: {
                        basePage.Stack.view.pop();
                    }
                }

                Label {
                    id: pageTitle
                    color: "white"
                }
            }
        }

        Loader {
            sourceComponent: toolBar
        }

        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: pageComponent
        }
    }

    function pushPage(page) {
        basePage.Stack.view.push(page);
    }
}
