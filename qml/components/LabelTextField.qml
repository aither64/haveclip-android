import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QuickAndroid 0.1

FocusScope {
    id: component

    property alias label: label.text
    property alias text: textField.text
    property var validator
    property var inputMethodHints
    property bool readOnly

    height: layout.height
    clip: true

    ColumnLayout {
        id: layout
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: label
            anchors.left: parent.left
            anchors.right: parent.right
            wrapMode: Text.Wrap
        }

        QATextInput {
            id: textField
            anchors.left: parent.left
            anchors.right: parent.right
            Layout.preferredHeight: 30 * A.dp
            focus: true
            textInput.readOnly: component.readOnly

            Binding {
                target: textField.textInput
                property: "validator"
                value: component.validator
                when: component.validator !== undefined
            }

            Binding {
                target: textField.textInput
                property: "inputMethodHints"
                value: component.inputMethodHints
                when: component.inputMethodHints !== undefined
            }
        }
    }
}
