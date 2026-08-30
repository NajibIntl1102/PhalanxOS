import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

QQC2.AbstractButton {
    id: control

    property string moduleLabel
    property string moduleIcon
    property string moduleDetail
    property color accentColor: "#dc143c"
    property color glowColor: "#ff335f"
    property int animationIntensity: 2

    implicitHeight: Kirigami.Units.gridUnit * 3.2
    hoverEnabled: true

    background: Rectangle {
        radius: Kirigami.Units.smallSpacing
        color: control.hovered ? Qt.rgba(0.15, 0.03, 0.05, 0.82) : Qt.rgba(0.10, 0.12, 0.14, 0.72)
        border.color: control.hovered ? control.glowColor : Qt.rgba(0.45, 0.48, 0.52, 0.35)
        border.width: 1
        Behavior on color { ColorAnimation { duration: 90 + (control.animationIntensity * 45) } }
    }

    contentItem: RowLayout {
        spacing: Kirigami.Units.smallSpacing
        Kirigami.Icon {
            source: control.moduleIcon
            color: control.accentColor
            Layout.preferredWidth: Kirigami.Units.iconSizes.smallMedium
            Layout.preferredHeight: Kirigami.Units.iconSizes.smallMedium
        }
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0
            QQC2.Label { text: control.moduleLabel; color: "white"; font.bold: true }
            QQC2.Label { text: control.moduleDetail; color: "#aeb5bd"; elide: Text.ElideRight; Layout.fillWidth: true }
        }
        Rectangle {
            width: Kirigami.Units.smallSpacing
            height: parent.height * 0.65
            radius: width / 2
            color: control.accentColor
            opacity: control.hovered ? 1.0 : 0.45
        }
    }
}
