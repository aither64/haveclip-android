import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import cz.havefun.haveclip 1.0

Activity {
    id: page

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("About...")
        showTitle: true
        z: 10
        actionButtonEnabled: true
        onActionButtonClicked: back()
    }

    Flickable {
        anchors.top : actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: col1.height + col2.height

        ColumnLayout {
            id: col1
            anchors.top: parent.top
            anchors.topMargin: 50 * A.dp
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 10 * A.dp

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Style.theme.largeText.textSize * A.dp
                text: "HaveClip"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Style.theme.smallText.textSize * A.dp
                textFormat: Text.RichText
                text: page.styledRichText(
                          qsTr("version v") + manager.version + " (" + qsTr("commit") + " " +
                          '<a href="https://github.com/aither64/haveclip-android/tree/'+ manager.commitSha1 +'">' +
                          manager.commitSha1.slice(0, 7) +'</a>)')
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Clipboard synchronization tool")
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                font.pixelSize: Style.theme.smallText.textSize * A.dp
                text: page.styledRichText("<a href=\"http://www.havefun.cz/projects/haveclip/\">http://www.havefun.cz/projects/haveclip/</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        ColumnLayout {
            id: col2
            anchors.top: col1.bottom
            anchors.topMargin: 100 * A.dp
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 8 * A.dp

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Style.theme.smallText.textSize * A.dp
                text: "Developed by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                text: page.styledRichText("Jakub Skokan &lt;<a href=\"mailto:aither@havefun.cz\">aither@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Style.theme.smallText.textSize * A.dp
                text: "Icon created by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                text: page.styledRichText("Aleš Kocur &lt;<a href=\"mailto:kafe@havefun.cz\">kafe@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }

    function styledRichText(str) {
        return "<html>" +
                "<head><style type=\"text/css\">" +
                "a{color: "+ Style.theme.black87 +";}" +
                "</style></head>" +
                "<body>" +
                str +
                "</body>" +
                "</html>"
    }
}
