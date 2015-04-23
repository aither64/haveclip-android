import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ColumnLayout {
    id: field

    property string label
    property string placeholderText
    property string text
    property Component validator
    property int inputMethodHints
    property bool readOnly: false

    Label {
        text: field.label
        wrapMode: Text.Wrap
    }

    TextField {
        placeholderText: field.placeholderText
        text: field.text
        validator: field.validator
        inputMethodHints: field.inputMethodHints
        readOnly: field.readOnly
    }
}

