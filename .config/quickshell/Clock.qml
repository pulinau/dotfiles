import Quickshell
import QtQuick

Text {
    text: Qt.formatDateTime(clock.date, "HH:mm")
    color: "#3dd1b0"

    font {
        family: "SF Mono"
        letterSpacing: -0.5
        pixelSize: 15
        weight: 700
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
