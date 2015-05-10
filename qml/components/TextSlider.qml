import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

ColumnLayout {
    id: field
    anchors.left: parent.left
    anchors.right: parent.right

    property alias label: labelField.text
    property alias minimumValue: slider.minimumValue
    property alias maximumValue: slider.maximumValue
    property alias stepSize: slider.stepSize
    property alias value: slider.value
    property alias valueText: valueField.text
    property bool enabled: true

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        height: Math.max(labelField.height, valueField.height)

        Label {
            id: labelField
            width: parent.width - valueField.width - 20
            text: field.label
            wrapMode: Text.Wrap
        }

        Label {
            id: valueField
            width: contentWidth
            anchors.right: parent.right
            text: field.valueText
            horizontalAlignment: Text.AlignRight
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

        style: SliderStyle {
            groove: Rectangle {
                implicitWidth: 200
                implicitHeight: 1
                color: "#333333"
                radius: 1
            }

            handle: Rectangle {
                anchors.centerIn: parent
                color: "#e3728d"
                implicitWidth: 15
                implicitHeight: 15
                radius: 12
            }
        }
    }

    Binding {
        target: field
        property: "value"
        value: slider.value
    }
}
