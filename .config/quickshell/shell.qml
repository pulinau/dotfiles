import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 38
        color: "#040e0d"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            spacing: 8

            Workspaces {}

            Item {
                Layout.fillWidth: true
            }

            RowLayout {
                spacing: 25

                Network {}
                Volume {}
                Clock {}
            }
        }
    }
}
