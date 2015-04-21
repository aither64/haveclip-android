import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    id: basePage

    signal nextPage
    signal previousPage

    property alias pageTitle: pageTitle
    property Component pageComponent


    Rectangle {
        id: topBar
        width: parent.width
        height: 80
        anchors.top: parent.top
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
        sourceComponent: pageComponent
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
    }

    function pushPage(page) {
        basePage.Stack.view.push(page);
    }
}
