import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

MouseArea {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    property bool isBluetoothOn: adapter ? adapter.state === BluetoothAdapterState.Enabled : false
    property int connectedCount: {
        if (!adapter)
            return 0;
        let count = 0;
        for (let i = 0; i < adapter.devices.count; i++) {
            if (adapter.devices.values[i].connected)
                count++;
        }
        return count;
    }

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    onClicked: {
        popup.visible = !popup.visible;
    }

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 4

        Text {
            text: root.enabled ? (root.connectedCount > 0 ? "󰂱" : "󰂯") : "󰂲"
            color: root.enabled ? (root.connectedCount > 0 ? "#0db9d7" : "#7aa2f7") : "#444b6a"
            font {
                family: "CaskaydiaCove NerdFont Propo"
                pixelSize: 15
                weight: 600
            }
        }

        Text {
            visible: root.connectedCount > 0
            text: root.connectedCount
            color: "#0db9d7"
            font {
                family: "CaskaydiaCove NerdFont Propo"
                pixelSize: 12
                weight: 600
            }
        }
    }

    PopupWindow {
        id: popup
        anchor.window: QsWindow.window
        anchor.rect.x: root.width - popupContent.width
        anchor.rect.y: root.height + 6
        visible: false
        implicitWidth: popupContent.width
        implicitHeight: popupContent.height
        color: "transparent"

        Rectangle {
            id: popupContent
            width: 260
            height: contentColumn.implicitHeight + 24
            radius: 10
            color: "#1a1b26"
            border.color: "#292e42"
            border.width: 1

            ColumnLayout {
                id: contentColumn
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                // Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "󰂯"
                        color: "#7aa2f7"
                        font {
                            family: "CaskaydiaCove NerdFont Propo"
                            pixelSize: 16
                            weight: 600
                        }
                    }

                    Text {
                        text: "Bluetooth"
                        color: "#c0caf5"
                        font {
                            family: "CaskaydiaCove NerdFont Propo"
                            pixelSize: 13
                            weight: 600
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    // Toggle switch
                    Rectangle {
                        width: 36
                        height: 20
                        radius: 10
                        color: root.enabled ? "#0db9d7" : "#292e42"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        Rectangle {
                            width: 16
                            height: 16
                            radius: 8
                            x: root.enabled ? parent.width - width - 2 : 2
                            y: 2
                            color: root.enabled ? "#1a1b26" : "#565f89"

                            Behavior on x {
                                NumberAnimation {
                                    duration: 150
                                    easing.type: Easing.InOutQuad
                                }
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (root.adapter)
                                    root.adapter.enabled = !root.adapter.enabled;
                            }
                        }
                    }
                }

                // Separator
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#292e42"
                }

                // Paired devices label
                Text {
                    text: "Paired Devices"
                    color: "#565f89"
                    font {
                        family: "CaskaydiaCove NerdFont Propo"
                        pixelSize: 11
                        weight: 500
                    }
                }

                // Device list
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2
                    visible: root.adapter !== null

                    Repeater {
                        model: root.adapter ? root.adapter.devices : []

                        Rectangle {
                            Layout.fillWidth: true
                            height: deviceRow.implicitHeight + 12
                            radius: 6
                            color: deviceMouse.containsMouse ? "#292e42" : "transparent"

                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }

                            RowLayout {
                                id: deviceRow
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8
                                anchors.topMargin: 6
                                anchors.bottomMargin: 6
                                spacing: 8

                                Text {
                                    text: modelData.connected ? "󰂱" : "󰂳"
                                    color: modelData.connected ? "#0db9d7" : "#565f89"
                                    font {
                                        family: "CaskaydiaCove NerdFont Propo"
                                        pixelSize: 14
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 1

                                    Text {
                                        text: modelData.name || modelData.address
                                        color: "#c0caf5"
                                        font {
                                            family: "CaskaydiaCove NerdFont Propo"
                                            pixelSize: 12
                                            weight: 500
                                        }
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.connected ? "Connected" : "Paired"
                                        color: modelData.connected ? "#0db9d7" : "#565f89"
                                        font {
                                            family: "CaskaydiaCove NerdFont Propo"
                                            pixelSize: 10
                                        }
                                    }
                                }

                                // Battery indicator
                                Text {
                                    visible: modelData.batteryAvailable
                                    text: {
                                        let pct = Math.round(modelData.battery * 100);
                                        if (pct > 75)
                                            return "󰁹 " + pct + "%";
                                        if (pct > 50)
                                            return "󰁾 " + pct + "%";
                                        if (pct > 25)
                                            return "󰁼 " + pct + "%";
                                        return "󰁺 " + pct + "%";
                                    }
                                    color: {
                                        let pct = Math.round(modelData.battery * 100);
                                        if (pct > 50)
                                            return "#9ece6a";
                                        if (pct > 25)
                                            return "#e0af68";
                                        return "#f7768e";
                                    }
                                    font {
                                        family: "CaskaydiaCove NerdFont Propo"
                                        pixelSize: 10
                                    }
                                }
                            }

                            MouseArea {
                                id: deviceMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (modelData.connected) {
                                        modelData.disconnect();
                                    } else {
                                        modelData.connect();
                                    }
                                }
                            }
                        }
                    }
                }

                // No devices message
                Text {
                    visible: !root.adapter || root.adapter.devices.count === 0
                    text: root.enabled ? "No paired devices" : "Bluetooth is off"
                    color: "#565f89"
                    font {
                        family: "CaskaydiaCove NerdFont Propo"
                        pixelSize: 11
                    }
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 8
                    Layout.bottomMargin: 8
                }

                // Separator
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#292e42"
                }

                // Scan / Pair button
                Rectangle {
                    Layout.fillWidth: true
                    height: 32
                    radius: 6
                    color: scanMouse.containsMouse ? "#3b4261" : "#292e42"

                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6

                        Text {
                            text: root.adapter && root.adapter.discovering ? "󰂰" : "󰍉"
                            color: root.adapter && root.adapter.discovering ? "#0db9d7" : "#7aa2f7"
                            font {
                                family: "CaskaydiaCove NerdFont Propo"
                                pixelSize: 14
                            }

                            RotationAnimation on rotation {
                                running: root.adapter ? root.adapter.discovering : false
                                from: 0
                                to: 360
                                duration: 2000
                                loops: Animation.Infinite
                            }
                        }

                        Text {
                            text: root.adapter && root.adapter.discovering ? "Scanning..." : "Scan for devices"
                            color: "#c0caf5"
                            font {
                                family: "CaskaydiaCove NerdFont Propo"
                                pixelSize: 12
                                weight: 500
                            }
                        }
                    }

                    MouseArea {
                        id: scanMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (root.adapter) {
                                root.adapter.discovering = !root.adapter.discovering;
                            }
                        }
                    }
                }
            }
        }
    }
}
