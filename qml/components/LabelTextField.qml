import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

FocusScope {
    property alias label: label.text
    property alias placeholderText: textField.placeholderText
    property alias text: textField.text
    property alias validator: textField.validator
    property alias inputMethodHints: textField.inputMethodHints
    property alias readOnly: textField.readOnly

    height: layout.height

    ColumnLayout {
        id: layout

        Label {
            id: label
            wrapMode: Text.Wrap
        }

        TextField {
            id: textField
            focus: true
        }
    }
}
