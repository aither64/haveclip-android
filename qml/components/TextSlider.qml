import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

ColumnLayout {
    id: field
    anchors.left: parent.left
    anchors.right: parent.right

    property string label
    property real minimumValue: 0.0
    property real maximumValue: 1.0
    property real stepSize: 0.1
    property real value: 0
    property string valueText: value
    property bool enabled: true

    Label {
        text: field.label
    }

    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 30

        Label {
            text: field.valueText
            x: {
                var percent = slider.maximumValue / 100 * slider.value;
                var pos = (percent / 100 * slider.width) - width / 2;

                if (pos < 0)
                    pos = 0;

                var field_x = field.x + field.width;

                if (pos + width > field_x)
                    pos = field_x - width;

                return pos;
            }
        }
    }

    Slider {
        id: slider
        anchors.left: parent.left
        anchors.right: parent.right
        minimumValue: field.minimumValue
        maximumValue: field.maximumValue
        stepSize: field.stepSize
        value: field.value
        enabled: field.enabled
    }

    Binding {
        target: field
        property: "value"
        value: slider.value
    }
}
